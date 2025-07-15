vim9script

if !executable('sourcekit-lsp')
    :echomsg "sourcekit-lsp not found"
    finish
endif

var server_info = {
    name: 'sourcekit-lsp',
    cmd: (server_info) => [
        'xcrun', 'sourcekit-lsp',
        '-Xswiftc', '"-sdk"',
        '-Xswiftc', '"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator18.5.sdk"',
        '-Xswiftc', '"-target"',
        '-Xswiftc', '"arm64-apple-ios18.5-simulator"',
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
        autocmd User lsp_setup {
            lsp#register_server(server_info)
        }
        autocmd BufWritePre *.swift {
            execute 'LspDocumentFormat'
        }
    augroup END
endif

defcompile
