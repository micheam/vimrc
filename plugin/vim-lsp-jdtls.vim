vim9script

if !executable('jdtls')
    finish
endif

# For MacOS (Homebrew):
# https://formulae.brew.sh/formula/jdtls
var server_info = {
    name: 'jdtls',
    cmd: (server_info) => ['jdtls'],
    allowlist: ['java'],
    config: {},
    root_uri: (server_info) => {
        return lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(),
            ['settings.gradle', 'pom.xml', 'build.gradle', '.project', '.classpath', 'WORKSPACE', 'BUILD', 'BUCK']))
    },
    workspace_config: {},
    initialization_options: {
        'ui.inlayhint.hints': {
            assignVariableTypes: true,
            compositeLiteralFields: true,
            compositeLiteralTypes: true,
            constantValues: true,
            functionTypeParameters: true,
            parameterNames: true,
            rangeVariableTypes: true,
        }
    },
    semantic_highlight: {},
}

if executable('jdtls')
    augroup lsp_jdtls
        autocmd!
        autocmd User lsp_setup call lsp#register_server(server_info)

        g:lsp_inlay_hints_enabled = true
    augroup END
endif

defcompile
