vim9script

setlocal concealcursor=nc
setlocal foldmethod=expr
setlocal foldexpr=FoldMarkdownDetails(v:lnum)
setlocal conceallevel=0

def FoldMarkdownDetails(lnum: number): string
    const line = getline(lnum)
    if line =~ '^<details>'
        return 'a1'
    elseif line =~ '</details>$'
        return 's1'
    endif
    return '='
enddef

################################################################################
# Code Fence Support

const fence_marker = '```' # maybe change to ~~~
const languages = [
    'plaintext', # use as default
    'bash', 'c', 'cpp', 'css', 'go', 'html', 'java', 'javascript', 'js',
    'json', 'markdown', 'php', 'python', 'ruby', 'rust',
    'sh', 'sql', 'typescript', 'ts', 'vim', 'xml', 'yaml'
]

def CodeFenceLines(lnum_start: number, lnum_end: number, lang: string): void
    const actual_lang = lang == '' ? languages[0] : lang
    const fence_start = $"{fence_marker}{actual_lang}"
    call append(lnum_end, fence_marker)
    call append(lnum_start - 1, fence_start)
enddef

def CompleteLang(ArgLead: string, CmdLine: string, CursorPos: number): list<string>
    return languages->filter((_, v) => v =~ $"^{ArgLead}")
enddef

command! -range -nargs=?  -complete=customlist,CompleteLang
            \ CodeFenceLines call CodeFenceLines(<line1>, <line2>, <q-args>)

################################################################################
# Toggle ConcealLevel
#
# markdown ファイルを編集する際には、conceallevel は 0
# としたいが、参照する際には、conceallevel は 3 としたいことが多い。
# ここでは、それらの切り替えを簡易に行うための関数を定義している。
setlocal conceallevel=3
command! ConcealEnable {
        setlocal conceallevel=3 
    }
command! ConcealDisable {
        setlocal conceallevel=0
    }


defcompile
