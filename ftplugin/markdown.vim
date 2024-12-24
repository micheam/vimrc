vim9script
setlocal conceallevel=3
setlocal concealcursor=nc
setlocal foldmethod=expr
setlocal foldexpr=FoldMarkdownDetails(v:lnum)

def FoldMarkdownDetails(lnum: number): string
    const line = getline(lnum)
    if line =~ '<details>'
        return 'a1'
    elseif line =~ '</details>'
        return 's1'
    endif
    return '='
enddef

defcompile
