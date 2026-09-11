vim9script
# test/diff_apply_test.vim - autoload/diff_apply.vim のテスト
#
# 実行方法:
#   test/run.sh
# または:
#   vim -u NONE -N -es -S test/diff_apply_test.vim
#
# 組み込みの assert_equal() / assert_true() 等を使い、失敗内容は v:errors に
# 溜まる。フレームワークは使わず、Test_ で始まる関数を順に呼ぶだけの最小構成。

var repo_root = expand('<script>:p:h:h')
execute 'set rtp+=' .. fnameescape(repo_root)
import autoload 'diff_apply.vim' as da

def Test_ParseDiff_SingleHunk()
  var d = da.ParseDiff([
    '@@ -17,2 +17,3 @@',
    ' hello, world.',
    '-foo, bar',
    '+FOO, BAR',
    '+',
  ])
  assert_equal(17, d.from.start)
  assert_equal(['hello, world.', 'foo, bar'], d.from.lines)
  assert_equal(17, d.to.start)
  assert_equal(['hello, world.', 'FOO, BAR', ''], d.to.lines)
enddef

def Test_ParseDiff_HunkLessSnippet()
  # hunk ヘッダが無い「diff 風」テキストも解析できる
  var d = da.ParseDiff([
    ' hello, world.',
    '-foo, bar',
    '+FOO, BAR',
  ])
  assert_equal(0, d.from.start)
  assert_equal(['hello, world.', 'foo, bar'], d.from.lines)
  assert_equal(['hello, world.', 'FOO, BAR'], d.to.lines)
enddef

def Test_ParseDiff_MultipleHunksThrows()
  var threw = false
  try
    da.ParseDiff([
      '@@ -1,1 +1,1 @@',
      '-a',
      '+b',
      '@@ -10,1 +10,1 @@',
      '-c',
      '+d',
    ])
  catch
    threw = true
  endtry
  assert_true(threw, '複数 hunk では例外が throw されるはず')
enddef

def RunTests()
  for fn in [
      'Test_ParseDiff_SingleHunk',
      'Test_ParseDiff_HunkLessSnippet',
      'Test_ParseDiff_MultipleHunksThrows',
  ]
    try
      call function(fn)()
    catch
      add(v:errors, $'{fn}: 予期しない例外: {v:exception}')
    endtry
  endfor

  # -es (silent ex mode) では echo は標準出力に出ないため /dev/stdout に書く
  if empty(v:errors)
    writefile(['OK: all tests passed'], '/dev/stdout')
    quitall!
  else
    var out = [$'NG: {len(v:errors)} failure(s)']
    out->extend(v:errors)
    writefile(out, '/dev/stdout')
    cquit 1
  endif
enddef

RunTests()
