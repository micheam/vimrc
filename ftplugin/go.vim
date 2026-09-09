vim9script

setlocal previewheight=5
setlocal tabstop=4
setlocal shiftwidth=4

def GoPackage(): string
    const org_cwd = getcwd(0)
    var result = ""
    try
        silent! lcd %:p:h
        const slist = systemlist('go list .')
        if !v:shell_error
            result = slist->get(0, "NONE")
        endif
    finally
        execute 'silent! lcd ' .. fnameescape(org_cwd)
    endtry
    return result
enddef

def GoDoc(symbol: string = ""): list<string>
    var target = symbol
    if target == ""
        target = GoPackage()
        if target == ""
            return ["NONE"]
        endif
    endif
    const cmd = $"go doc {shellescape(target)}"
    const lines = systemlist(cmd)
    if v:shell_error
        return ["NONE"]
    endif
    return lines
enddef

def ShowInPreview(lines: list<string>, ft: string = "go")
    silent! pclose
    silent! new __GoDoc__
    setlocal previewwindow
    setlocal buftype=nofile bufhidden=wipe noswapfile
    setlocal nobuflisted
    execute $'setlocal filetype={ft}'
    setlocal modifiable
    setline(1, lines)
    setlocal nomodifiable nomodified
    execute $'resize {&previewheight}'
    wincmd p
enddef

def ShowInPopup(lines: list<string>)
    popup_create(lines, {
        pos: 'center',
        border: [],
        padding: [0, 1, 0, 1],
        maxheight: 20,
        scrollbar: true,
        close: 'click',
    })
enddef

command GoPackage {
    echo GoPackage()
}

command -nargs=? GoDoc {
    ShowInPreview(GoDoc(<q-args>), "text")
}

setlocal foldmethod=syntax
setlocal nofoldenable
setlocal foldcolumn=0
setlocal foldlevel=0
setlocal foldminlines=3
setlocal foldtext=GoFoldText()
setlocal fillchars=fold:\ ,foldclose:>,foldopen:╭,foldsep:│,foldinner:\│
highlight! link FoldColumn Folded

def GoFoldText(): string
  const start = substitute(getline(v:foldstart), '\t', '    ', 'g')
  const end_ = substitute(getline(v:foldend), '\t', '', 'g')
  const num_ = v:foldend - v:foldstart
  return start .. "/* " .. num_ .. " lines */" .. end_
enddef

defcompile
