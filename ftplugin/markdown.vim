vim9script
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

#################################################################################################################################
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
