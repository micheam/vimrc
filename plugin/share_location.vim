vim9script

def Location(start: number, end: number, range: number): string

    # range comes from <range> in the command line.
    #
    # * 0: no range, just line numbers. (:SomeCommand)
    # * 1: line numbers only. (:123SomeCommand)
    # * 2: start and end line numbers. (:123,456SomeCommand)

    const filename = expand('%')
    
    if range < 2
        # line numbers only
        if start == end
            return $"{filename}:{start}"
        else
            return $"{filename}:{start}-{end}"
        endif
    else
        const start_col = col("'<")
        const end_col = col("'>")
        return $"{filename}:{start}:{start_col}-{end}:{end_col}"
    endif
enddef

command! -range ShareLocation {
    const loc = Location(<line1>, <line2>, <range>)
    @+ = loc
    echo $"File location: {loc}"
    }

