vim9script

if !executable('gopls')
    :echomsg "gopls not found"
    finish
endif

if !exists('g:lsp_log_file')
    g:lsp_log_file = '' # expand('~/vim-lsp.log')
endif

# see more info at: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
var server_info = {
    name: 'gopls',
    cmd: (server_info) => ['gopls'],
    allowlist: ['go'],
    config: {},
    root_uri: (server_info) => {
        return lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'go.mod'))
    },
    workspace_config: {
        usePlaceholders: true,    
        analyses: {
            unreachable: true,
            unusedparams: true,
        },
        staticcheck: true,
        hoverKind: 'FullDocumentation',
        completeUnimported: true,
        completionDocumentation: true,
        deepCompletion: true,
        codelenses: {
            generate: true,
            tidy: true,
            upgrade_dependency: true,
        },
    },
    semantic_highlight: {},
}

# call legacy vim script function
call lsp#register_server(server_info)

defcompile
