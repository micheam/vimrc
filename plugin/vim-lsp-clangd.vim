vim9script

if !executable('clangd')
    :echomsg "clangd not found"
    finish
endif

var server_info = {
    name: 'clangd',
    cmd: (server_info) => ['clangd'],
    whitelist: ['c', 'cpp', 'objc', 'objcpp', 'cuda'],
    config: {},
    workspace_config: {},
    semantic_highlight: {},
}

if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server(server_info)
    augroup END
endif

defcompile
