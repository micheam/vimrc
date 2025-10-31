vim9script

set previewheight=5
set tabstop=4
set shiftwidth=4

def Package(): string
    const org_cwd = getcwd(0)
    lcd %:p:h
    const slist = systemlist('go list .')
    execute 'lcd ' .. org_cwd 
    if v:shell_error
        return ""
    endif
    return slist->get(0, "NONE")
enddef

command Package {
        echo Package()
    }

set foldmethod=syntax
set nofoldenable
set foldtext=GoFoldText()
def GoFoldText(): string
  const start = substitute(getline(v:foldstart), '\t', '    ', 'g')
  const end_ = substitute(getline(v:foldend), '\t', '', 'g')
  const num_ = v:foldend - v:foldstart
  return start .. "/* " .. num_ .. " lines */" .. end_
enddef

defcompile
