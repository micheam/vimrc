vim9script

                 

command! -range Remove {
    const [start: number, end: number] = [<line1>, <line2>]
    var new_list = []
    var idx = 0
    for item in getqflist()
        idx += 1
        if start <= idx && idx <= end
            continue
        endif
        call add(new_list, item)
    endfor
    call setqflist(new_list)
}
