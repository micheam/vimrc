vim9script

if !executable('buf')
    :echomsg "buf not found"
    finish
endif

#
# Note: Currently, the buf language server is in beta.
#
#   $ buf --version
#   1.48.0  
#   $ buf beta lsp --help
#   Start the language server
#   
#   Usage:
#     buf beta lsp [flags]
#   
#   Flags:
#     -h, --help          help for lsp
#         --pipe string   path to a UNIX socket to listen on; uses stdio if not specified
#   
#   Global Flags:
#         --debug               Turn on debug logging
#         --log-format string   The log format [text,color,json] (default "color")
#         --timeout duration    The duration until timing out, setting it to zero means no timeout (default 2m0s)
#
#
# * https://buf.build/docs/reference/cli/buf/beta/lsp/
# * https://github.com/bufbuild/buf-language-server?tab=readme-ov-file
# * https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#buf_ls
#

var server_info = {
    name: 'buf',
    cmd: (server_info) => [
        'buf',
        'beta',
        'lsp',
        '--debug',
        '--timeout=0',
        '--log-format=text',
    ],
    allowlist: ['proto'],
    config: {},
    root_uri: (server_info) => {
        return lsp#utils#path_to_uri(
            lsp#utils#find_nearest_parent_file_directory(
                lsp#utils#get_buffer_path(), ['buf.yaml', '.git']))
    },
    workspace_config: {},
    initialization_options: {},
}

if executable('buf')
    augroup lsp_bufcli
        autocmd!
        autocmd User lsp_setup call lsp#register_server(server_info)
    augroup END
endif

defcompile
