vim9script

if !executable('efm-langserver')
    :echomsg "efm-langserver not found"
    finish
endif

var server_info = {
    name: 'efm-langserver',
    cmd: (server_info) => ['efm-langserver', '-c=' .. expand('~/.config/efm-langserver/config.yaml')],
    allowlist: [
        'go',
        'typescript',
        'javascript',
        'html',
        'swift',
        'elm',
        'kotlin',
        'sh',
    ],
}

if executable('efm-langserver')
    augroup LspEFM
        autocmd!
        autocmd User lsp_setup call lsp#register_server(server_info)
    augroup END
endif

defcompile
