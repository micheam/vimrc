vim9script

if !executable('zls')
    :echomsg "zls not found"
    finish
endif

if !exists('g:lsp_log_file')
    g:lsp_log_file = '' # expand('~/vim-lsp.log')
endif

var server_info = {
    name: 'zls',
    cmd: (server_info) => ['zls'],
    whitelist: ['zig'],
    config: {},
    workspace_config: {},
    semantic_highlight: {},
}

# call legacy vim script function
call lsp#register_server(server_info)

defcompile
