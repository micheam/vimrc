vim9script

g:frontmatter_autopopup_enabled = true

# YAML frontmatter をパースして popup でテーブル表示する。
#
# MVP の対応範囲:
#   - スカラー (key: value)、クォート ("..." / '...') は剥がす
#   - ブロックスタイルのリスト (key: の次行以降の "- item")
# 非対応 (生文字列のまま表示):
#   - ネストした map、フロースタイル [a, b]、複数行スカラー

const KEY_PROP_TYPE = 'FrontmatterKey'

if empty(prop_type_get(KEY_PROP_TYPE))
    prop_type_add(KEY_PROP_TYPE, {highlight: 'Title'})
endif

def StripQuotes(s: string): string
    if s =~ '^".*"$' || s =~ "^'.*'$"
        return s[1 : -2]
    endif
    return s
enddef

# バッファ行から frontmatter を抽出し、順序付きの
# [{key: string, value: string|list<string>}, ...] に変換する。
# frontmatter が無い (先頭が "---" でない、閉じ "---" が無い) 場合は空リスト。
export def Parse(lines: list<string>): list<dict<any>>
    if len(lines) == 0 || lines[0] !~ '^---\s*$'
        return []
    endif
    var entries: list<dict<any>> = []
    var i = 1
    while i < len(lines)
        const line = lines[i]
        if line =~ '^---\s*$'
            return entries
        endif
        const m = matchlist(line, '^\(\S[^:]*\):\s*\(.*\)$')
        if !empty(m)
            const key = m[1]
            const scalar = trim(m[2])
            if scalar == ''
                var items: list<string> = []
                while i + 1 < len(lines) && lines[i + 1] =~ '^\s\+-\s'
                    items->add(StripQuotes(trim(lines[i + 1]->substitute('^\s\+-\s\+', '', ''))))
                    i += 1
                endwhile
                entries->add({key: key, value: empty(items) ? '' : items})
            else
                entries->add({key: key, value: StripQuotes(scalar)})
            endif
        endif
        i += 1
    endwhile
    return []
enddef

export def Exists(): bool
    return len(Parse(getline(1, 50))) > 0
enddef

# popup の表示位置。g:frontmatter_popup_pos で切り替える。
#   'topright' (デフォルト): カレントウィンドウの右上に固定
#   'cursor': カーソルの直下
def PopupPosOpts(): dict<any>
    const pos = get(g:, 'frontmatter_popup_pos', 'topright')
    if pos == 'cursor'
        return {pos: 'topleft', line: 'cursor+1', col: 'cursor'}
    endif
    # topright (未知の値もこちらにフォールバック)
    const [wrow, wcol] = win_screenpos(0)
    return {pos: 'topright', line: wrow, col: wcol + winwidth(0) - 1}
enddef

# Popup を自動で表示するかどうか
export def AutoPopupEnabled(): bool
    return get(g:, 'frontmatter_autopopup_enabled', false)
enddef

# 表示中の popup の winid。閉じている (または未表示の) 場合は 0。
var popup_id = 0

def IsOpen(): bool
    return popup_id != 0 && !empty(popup_getpos(popup_id))
enddef

export def Close(): void
    if IsOpen()
        popup_close(popup_id)
    endif
    popup_id = 0
enddef

export def Toggle(): void
    if IsOpen()
        Close()
    else
        Show()
    endif
enddef

# カレントバッファの frontmatter を縦積みレイアウトの popup で表示する。
# popup は :FrontmatterClose (または Toggle) で閉じるまで表示され続ける。
export def Show(): void
    Close()
    const entries = Parse(getline(1, '$'))
    if empty(entries)
        echo 'No YAML frontmatter found.'
        return
    endif

    var text: list<dict<any>> = []
    for entry in entries
        const keytext = entry.key .. ':'
        text->add({
            text: keytext,
            props: [{col: 1, length: len(keytext), type: KEY_PROP_TYPE}],
        })
        if type(entry.value) == v:t_list
            for item in entry.value
                text->add({text: $'- {item}'})
            endfor
        else
            text->add({text: entry.value})
        endif
        text->add({text: ''})
    endfor
    text->remove(-1) # 末尾の空行を除去 (padding で余白を取るため)

    popup_id = popup_create(text, PopupPosOpts()->extend({
        border: [1, 1, 1, 1],
        borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
        padding: [1, 2, 1, 2],
        minwidth: 24,
        maxwidth: 40,
        wrap: true,
    }))
enddef

defcompile
