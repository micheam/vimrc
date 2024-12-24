set previewheight=5
set tabstop=4
set shiftwidth=4

function! go#echo_package()
    function! HandleMsg(ch, msg)
        echomsg "Packge: " . a:msg
    endfunction
    let job = job_start('go list .', {
                \ 'cwd': expand('%:p:h'),
                \ 'callback': 'HandleMsg',
                \ })
    return job
endfunction

function! go#package() abort
    let org_cwd = getcwd('.')
    lcd %:p:h
    let slist=systemlist('go list .')
    execute 'lcd' . org_cwd 
    if v:shell_error
        return ""
    endif
    return slist->get(0, "NONE")
endfunction

command Package :call go#echo_package()

set foldmethod=syntax
set nofoldenable
set foldtext=GoFoldText()
function! GoFoldText()
  let start = substitute(getline(v:foldstart), '\t', '    ', 'g')
  let end_ = substitute(getline(v:foldend), '\t', '', 'g')
  let num_ = v:foldend - v:foldstart
  return start .. "/* " .. num_ .. " lines */" .. end_
endfunction
