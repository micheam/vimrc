vim9script

# QuickRun configuration for Zig {{{1 ============================================================================================

if !exists('g:quickrun_config')
    g:quickrun_config = {}
endif

g:quickrun_config.zigtest = {
    'exec': 'zig test %s',
    'outputter/buffer/type': 'new', # Open results in a new buffer
}

nnoremap <buffer> <leader>r :QuickRun<CR>
nnoremap <buffer> <leader>t :QuickRun zigtest<CR>

# }}}1
