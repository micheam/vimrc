vim9script

if !executable('sourcekit-lsp')
    :echomsg "sourcekit-lsp not found"
    finish
endif

if !exists('g:lsp_log_file')
    g:lsp_log_file = '' # expand('~/vim-lsp.log')
endif

var server_info = {
    name: 'sourcekit-lsp',
    cmd: (server_info) => [
        'sourcekit-lsp',
        '-Xswiftc',
        '-sdk',
        '-Xswiftc',
        '/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator18.2.sdk',
        '-Xswiftc',
        '-target',
        '-Xswiftc',
        'x86_64-apple-ios18.2-simulator',
    ],
    allowlist: ['swift'],
    config: {},
    root_uri: (server_info) => {
        return lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(
            lsp#utils#get_buffer_path(),
            ['Package.swift', '.git/']
        ))
    },
    workspace_config: {},
    initialization_options: {},
    semantic_highlight: {},
}

if executable('xcrun')
    augroup lsp_sourcekit
        autocmd!
        autocmd User lsp_setup call lsp#register_server(server_info)
        autocmd BufWritePre *.swift call execute('LspDocumentFormatSync --server=efm-langserver')
    augroup END
endif

defcompile
