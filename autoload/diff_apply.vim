vim9script

# diff_apply.vim - レジスタ内の unified diff をカレントバッファに適用する
#
# 概要:
#   LLM の出力などから得た diff スニペットをレジスタに入れ、:DiffApply でバッファへ
#   反映するためのモジュール。厳密な unified diff だけでなく、hunk ヘッダのない
#   「diff 風」テキストや、``` / ~~~ フェンスで囲まれたものも受け付ける。
#
# 公開 API:
#   ParseDiff(text: list<string>): DiffInfo
#       diff テキストを解析し、変更前 (from) / 変更後 (to) の行と位置を返す。
#   Apply(line1, line2, nrange, bang, reg)
#       :DiffApply コマンドの実装。ParseDiff の結果をバッファへ適用する。
#
# 組み込み例 (plugin/diff_apply.vim):
#   import autoload 'diff_apply.vim' as da
#   command! -range -bang -register DiffApply
#       \ da.Apply(<line1>, <line2>, <range>, <bang>false, <q-reg>)
#
#   :[range]DiffApply[!] ["x]
#       range 省略時は diff の hunk ヘッダから位置を決める。
#       ! を付けると変更前テキストとの照合をスキップして強制適用する。
#
# 設計方針:
#   - hunk ヘッダの行数 (count) は信用せず、実際の行数から算出する
#     (LLM は行数を誤りやすいため)。
#   - 変更前テキストとの照合は行ごとに trim() して比較する (行頭・行末の空白差を許容)。
#   - 複数 hunk は未対応。2 つ目の hunk ヘッダを検出した場合はエラーにする。
#   - 適用先は常にカレントバッファ ('%')。
#
# Maintainer: Michito Maeda <michito.maeda@gmail.com>
# License:    MIT

# DiffSide は、diff の片側 (変更前 or 変更後) を表す。
# start が 0 のときは位置未知 (hunk ヘッダなし) を意味する。
class DiffSide
  var start: number = 0
  var count: number = 0
  var lines: list<string> = []
endclass

# DiffInfo は、ParseDiff の解析結果。
class DiffInfo
  var from: DiffSide
  var to: DiffSide
endclass

# ParseDiff は、unified diff 形式テキスト（もしくは diff-like スニペット[^1]）を解析し、
# 構造化された変更前後のテキスト情報を返却する。
#
# Input:
#    ~~~diff
#    @@ -17,2 +17,3 @@
#     hello, world.
#    -foo, bar
#    +FOO, BAR
#    +
#    ~~~
#
# Output:
#    {
#        from: {
#            start: 17,
#            count: 2,
#            lines: ["hello, world.", "foo, bar"]
#        },
#        to: {
#            start: 17,
#            count: 3,
#            lines: ["hello, world.", "FOO, BAR", ""]
#        }
#    }
#
# 仕様:
#   - hunk ヘッダ (@@ -a,b +c,d @@) は任意。無い場合 start は 0 (未知) とする。
#   - count はヘッダの値ではなく、実際に解析した行数から算出する
#     (LLM はヘッダの行数を誤りやすいため、ヘッダの count は信用しない)。
#   - 複数 hunk は未対応。2 つ目の hunk ヘッダを検出した場合は例外を throw する
#     (無視して連結すると、無関係な行を巻き込んで書き換えてしまうため)。
#   - コードフェンス (``` / ~~~) と、先頭に現れるファイルヘッダ (--- / +++) は無視する。
#   - 接頭辞のない行は context 行として扱う (LLM が空行の先頭空白を落とすため)。
#
# [^1]: 正式な呼称はわからないが、hunk-less diff や diff-style snippet と呼ばれるもの
export def ParseDiff(text: list<string>): DiffInfo
  var from_start = 0
  var to_start = 0
  var from_lines: list<string> = []
  var to_lines: list<string> = []
  var header_seen = false
  var body_started = false

  for l in text
    if l =~ '^\s*\%(```\|\~\~\~\)'
      continue
    endif
    if l =~ '^@@'
      var m = matchlist(l, '^@@ -\(\d\+\)\%(,\d\+\)\? +\(\d\+\)\%(,\d\+\)\? @@')
      if !empty(m)
        if header_seen
          throw '複数の hunk ヘッダが見つかりました（1回の適用では1 hunk のみ対応しています）'
        endif
        from_start = str2nr(m[1])
        to_start = str2nr(m[2])
        header_seen = true
      endif
      continue
    endif
    if !body_started && l =~ '^\%(---\|+++\) '
      continue
    endif
    body_started = true

    if l[0] == '+'
      to_lines->add(l[1 :])
    elseif l[0] == '-'
      from_lines->add(l[1 :])
    elseif l[0] == ' '
      from_lines->add(l[1 :])
      to_lines->add(l[1 :])
    else
      from_lines->add(l)
      to_lines->add(l)
    endif
  endfor

  return DiffInfo.new(
    DiffSide.new(from_start, len(from_lines), from_lines),
    DiffSide.new(to_start, len(to_lines), to_lines),
  )
enddef

# :[range]Apply[!] [register]
#   range    … diff の「変更前」に対応する行。省略時、diff に hunk ヘッダがあれば
#              その start/count を位置として使う
#   register … diff スニペットを保持するレジスタ (省略時は無名レジスタ)
#   !        … 変更前との一致検証をスキップして強制適用
export def Apply(line1: number, line2: number, nrange: number, bang: bool, reg: string)
  var regname = reg == '' ? '"' : reg
  var diff: DiffInfo
  try
    diff = ParseDiff(getreg(regname, 1, true))
  catch
    echoerr $'DiffApply: {v:exception}'
    return
  endtry
  if diff.from.count == 0 && diff.to.count == 0
    echoerr $'DiffApply: レジスタ {regname} に diff がありません'
    return
  endif

  # 適用位置の決定
  var top = line1
  var bot = line2
  if nrange == 0
    if diff.from.start == 0
      echoerr 'DiffApply: 範囲指定がなく、diff にも hunk ヘッダがありません'
      return
    endif
    top = diff.from.start
    bot = diff.from.start + diff.from.count - 1
  endif

  var cur = getline(top, bot)
  if !bang
    if len(cur) != diff.from.count
      echoerr $'DiffApply: 範囲の行数 ({len(cur)}) が diff の変更前 ({diff.from.count}) と一致しません'
      return
    endif
    for i in range(len(cur))
      if cur[i]->trim() != diff.from.lines[i]->trim()
        echoerr $'DiffApply: {top + i} 行目が不一致: "{cur[i]}" vs "{diff.from.lines[i]}"'
        return
      endif
    endfor
  endif

  deletebufline('%', top, bot)
  append(top - 1, diff.to.lines)
  cursor(top, 1)
  echo $'DiffApply: {top}-{bot} 行 ({diff.from.count} 行) -> {diff.to.count} 行'
enddef

silent defcompile
