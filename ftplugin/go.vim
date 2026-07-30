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

command GoPackage {
        echo GoPackage()
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
