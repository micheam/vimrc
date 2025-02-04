vim9script

if !executable('zls')
    :echomsg "zls not found"
    finish
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
if executable('zls')
    augroup lsp_zls
        autocmd!
        autocmd User lsp_setup call lsp#register_server(server_info)
    augroup END
endif

defcompile
