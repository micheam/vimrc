vim9script

# Automatically update the timestamp in the file.
#
# Created: 2021-08-15 13:49
# Last Updated: 2025-01-24T08:54:51+09:00
#
const default_keyword = '\c\(updated[ ,_]at\|last[ ,_]updated\)'
const defualt_limit = 15
const default_offset = 0
const default_format = '%Y-%m-%dT%H:%M:%S+09:00' # Timezone Offset 部分は、ワークラウンド...

const debug = 0
var auto_timestamp_enabled = 1

def Keyword(): string
    if exists('b:auto_timestamp_keyword') && !empty(b:auto_timestamp_keyword)
        return b:auto_timestamp_keyword
    endif
    if exists('g:auto_timestamp_keyword') && !empty(g:auto_timestamp_keyword)
        return g:auto_timestamp_keyword
    endif
    return default_keyword
enddef

def Limit(): number
    return exists('g:auto_timestamp_limit') ? g:auto_timestamp_limit : defualt_limit
enddef

def Offset(): number
    return exists('g:auto_timestamp_offset') ? g:auto_timestamp_offset : default_offset
enddef

def Format(): string
    return exists('g:auto_timestamp_format') ? g:auto_timestamp_format : default_format
enddef

# -------------------------------------------------------------------------------------------------------------------------------
# Define Functions
# -------------------------------------------------------------------------------------------------------------------------------

def UpdateTimestamp()
    if auto_timestamp_enabled == 0
        if debug
            echom "Auto timestamp is disabled..."
        endif
        return
    endif
    const keyword = Keyword()
    const offset = Offset()
    const count = Limit() < line('$') ? Limit() : line('$')
    const timestamp = strftime(Format())
    const cmd = $":{1 - offset},{count}s/{keyword}: \\zs.*/{timestamp}/g"
    if debug
        echom $"Executing: '{cmd}'"
    endif
    const saved_cursor = getpos('.')
    execute(cmd, 'silent!')
    call setpos('.', saved_cursor)
enddef

# -------------------------------------------------------------------------------------------------------------------------------
# Define Autocommands
# -------------------------------------------------------------------------------------------------------------------------------

augroup AutoTimestamp
    autocmd!
    autocmd BufWritePre * call UpdateTimestamp()
augroup END

# -------------------------------------------------------------------------------------------------------------------------------
# Define Commands
# -------------------------------------------------------------------------------------------------------------------------------

command! AutoTimestamp call UpdateTimestamp()
command! AutoTimestampEnable {
        auto_timestamp_enabled = 1
    }
command! AutoTimestampDisable {
        auto_timestamp_enabled = 0
    }

if debug
    echom "auto_timestamp loaded..."
endif

defcompile
