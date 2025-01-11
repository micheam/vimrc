" Global Setting
" ==============================================================================
let g:lsp_hover_ui = 'preview' " float, preview
let g:lsp_highlight_references_enabled = 1
highlight lspReference cterm=undercurl gui=undercurl

let g:lsp_diagnostics_virtual_text_enabled = 1
let g:lsp_diagnostics_virtual_text_align = "after"
let g:lsp_diagnostics_virtual_text_delay = 200
let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 1
highlight link LspErrorVirtualText ErrorMsg
highlight link LspWarningVirtualText WarningMsg
highlight LspInformationVirtualText cterm=italic ctermfg=39 gui=italic guifg=#0a9dff
highlight LspHintVirtualText cterm=italic ctermfg=39 gui=italic guifg=#0a9dff

let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_signs_error = {'text': '🧨'}
let g:lsp_diagnostics_signs_warning = {'text': '⚠️'}
let g:lsp_diagnostics_signs_information = {'text': 'ℹ️'}
let g:lsp_diagnostics_signs_hint = {'text': '💡'}
let g:lsp_diagnostics_signs_insert_mode_enabled = 1
let g:lsp_document_code_action_signs_enabled = 0
let g:lsp_async_completion = 1
let g:lsp_preview_fixup_conceal = 1

" inlay-hints
let g:lsp_inlay_hints_enabled = 0
" let g:lsp_inlay_hints_delay = 100
" highlight link lspInlayHintsType Comment
" highlight link lspInlayHintsParameter Comment

let g:lsp_show_message_log_level = 'info'
let g:lsp_log_file = expand("~/vim-lsp.log")
"let g:lsp_log_file = ''

" Highlight {{{1
" ==============================================================================
highlight LspErrorHighlight term=underline cterm=underline gui=underline
highlight link LspErrorText GruvboxRedSign
highlight lspReference term=underline cterm=underline

" highlight PopupWindow ctermfg=LightCyan ctermbg=Magenta guibg=NONE guifg=LightCyan
" augroup lsp_float_colours
"     autocmd!
"     autocmd User lsp_float_opened
"                 \ call win_execute(lsp#ui#vim#output#getpreviewwinid(),
"                 \		       'setlocal wincolor=PopupWindow')
" augroup end "}}}
" Register Servers {{{1
"
" Settings for each language server
" ==============================================================================

" Rust {{{2
if executable('rust-analyzer')
    augroup LspRust
        au!
        autocmd User lsp_setup call lsp#register_server({
                    \   'name': 'rust',
                    \   'cmd': {server_info->['rust-analyzer']},
                    \   'allowlist': ['rust'],
                    \   'initialization_options': {
                    \     'cargo': {
                    \       'buildScripts': {
                    \         'enable': v:true,
                    \       },
                    \     },
                    \     'procMacro': {
                    \       'enable': v:true,
                    \     },
                    \   },
                    \ })
    augroup END
endif
" }}}
" TypeScript {{{2
if executable('typescript-language-server')
    " NOTE: Install latest version of typescript-language-server
    " $ npm install -g typescript-language-server typescript
    augroup LspTypeScript
        au!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'typescript-language-server',
                    \ 'cmd': {server_info->['typescript-language-server', '--stdio']},
                    \ 'root_uri':{server_info->lsp#utils#path_to_uri(
                    \     lsp#utils#find_nearest_parent_file_directory(
                    \         lsp#utils#get_buffer_path(),
                    \         ['tsconfig.json', 'package.json']
                    \     ))},
                    \ 'allowlist': ['javascript', 'typescript'],
                    \ })
        autocmd FileType typescript setlocal omnifunc=lsp#complete
    augroup END
endif
" }}}
" Svelte {{{2
if executable('svelteserver')
    augroup LspSvelte
        au!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'svelte-language-server',
                    \ 'cmd': {server_info->['svelteserver', '--stdio']},
                    \ 'root_uri':{server_info->lsp#utils#path_to_uri(
                    \     lsp#utils#find_nearest_parent_file_directory(
                    \         lsp#utils#get_buffer_path(),
                    \         ['tsconfig.json', 'package.json', '.git/']
                    \     ))},
                    \ 'allowlist': ['svelte'],
                    \ })
        autocmd FileType svelte setlocal omnifunc=lsp#complete
    augroup END
endif
" }}}
" HTML {{{2
if executable('html-languageserver')
    augroup LspHTML
        au!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'html-languageserver',
                    \ 'cmd': {server_info->['html-languageserver', '--stdio']},
                    \ 'root_uri':{server_info->lsp#utils#path_to_uri(
                    \     lsp#utils#find_nearest_parent_file_directory(
                    \         lsp#utils#get_buffer_path(),
                    \         ['tsconfig.json', 'package.json', '.git/', 'index.html']
                    \     ))},
                    \ 'allowlist': ['html'],
                    \ })
        autocmd FileType html setlocal omnifunc=lsp#complete
    augroup END
else
    :echomsg "vim-lsp for typescript unavailable"
endif
" }}}
" CSS {{{2
if executable('css-languageserver')
    augroup LspCSS
        au!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'css-languageserver',
                    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'css-languageserver --stdio']},
                    \ 'root_uri':{server_info->lsp#utils#path_to_uri(
                    \     lsp#utils#find_nearest_parent_file_directory(
                    \         lsp#utils#get_buffer_path(),
                    \         ['tsconfig.json', 'package.json', '.git/', 'index.css']
                    \     ))},
                    \ 'allowlist': ['css'],
                    \ })
        autocmd FileType css setlocal omnifunc=lsp#complete
    augroup END
endif
" }}}
" OCaml {{{2
if executable('ocamllsp')
    augroup LspOcaml
        au!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'ocaml-lsp-server',
                    \ 'cmd': {server_info->['ocamllsp']},
                    \ 'root_uri':{server_info->lsp#utils#path_to_uri(
                    \     lsp#utils#find_nearest_parent_file_directory(
                    \         lsp#utils#get_buffer_path(),
                    \         ['dune-project', 'dune', '.git/']
                    \     ))},
                    \ 'allowlist': ['ocaml'],
                    \ 'initialization_options': v:null,
                    \ 'config': {},
                    \ 'workspace_config': {},
                    \ })
        autocmd FileType ocaml setlocal omnifunc=lsp#complete
    augroup END
endif
" }}}
" efm {{{2
if executable('efm-langserver')
  augroup LspEFM
    au!
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'efm-langserver',
        \ 'cmd': {server_info->['efm-langserver', '-c='.$HOME.'/.config/efm-langserver/config.yaml']},
        \ 'allowlist': [
        \   'go',
        \   'typescript',
        \   'javascript',
        \   'html',
        \   'swift',
        \   'elm',
        \   'kotlin',
        \   'sh',
        \   ],
        \ })
  augroup END
endif
" }}}
" elm {{{2
if executable('elm-language-server')
  augroup elmLS
    au!
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'elm-language-server',
        \ 'cmd': {server_info->['elm-language-server']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(
        \     lsp#utils#find_nearest_parent_file_directory(
        \         lsp#utils#get_buffer_path(),
        \         ['elm.json']
        \     ))},
        \ 'allowlist': ['elm'],
        \ })
  augroup END
endif
" }}}
" Kotlin {{{2
if executable('kotlin-language-server')
    augroup LspKotlin
        au!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'kotlin-language-server',
                    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'kotlin-language-server']},
                    \ 'root_uri':{server_info->lsp#utils#path_to_uri(
                    \     lsp#utils#find_nearest_parent_file_directory(
                    \         lsp#utils#get_buffer_path(),
                    \         ['settings.gradle.kts', 'settings.gradle', 'build.gradle.kts', 'build.grade', '.git/']
                    \     ))},
                    \ 'allowlist': ['kotlin'],
                    \ 'initialization_options': v:null,
                    \ 'config': {},
                    \ 'workspace_config': {},
                    \ })
        autocmd FileType kotlin setlocal omnifunc=lsp#complete
        autocmd BufWritePre *.kt call execute('LspDocumentFormatSync --server=efm-langserver')
    augroup END
endif
" }}}
" Protocol Buffer {{{2
if executable('bufls')
    augroup LspBuf
        au!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'bufls',
                    \ 'cmd': {server_info->['bufls', 'serve']},
                    \ 'allowlist': ['proto'],
                    \ 'initialization_options': v:null,
                    \ 'config': {},
                    \ 'workspace_config': {},
                    \ })

        " NOTE: buf format は stdin を対象にした format に対応していないため、
        "       BufWritePre で format すると、ファイルが空になってしまう。
        "       そのため、コマンド を定義して任意に実行する方針にしている。
        autocmd FileType proto command! -range Format call execute('LspDocumentFormatSync --server=efm-langserver')
        " autocmd BufWritePre *.swift call execute('LspDocumentFormatSync --server=efm-langserver')
        
    augroup END
endif
" }}}
" Bash {{{2
"
" https://github.com/bash-lsp/bash-language-server
if executable('bash-language-server')
    augroup LspBuf
        au!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'bash-language-server',
                    \ 'cmd': {server_info->['bash-language-server', 'start']},
                    \ 'allowlist': ['sh', 'bash'],
                    \ 'initialization_options': v:null,
                    \ 'config': {},
                    \ 'workspace_config': {},
                    \ })
else
    :echomsg "vim-lsp for bash unavailable"
endif

" Key Mappings & Commands {{{1
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete

    " Key Mappings {{{2
    " nnoremap <plug>(lsp-code-lens)
    " nnoremap <plug>(lsp-declaration)
    " nnoremap <plug>(lsp-peek-declaration)
    nmap <buffer> <F12> <plug>(lsp-definition)
    nmap <buffer> <C-]> <plug>(lsp-definition)
    " nnoremap <plug>(lsp-document-symbol)
    nmap <buffer> <space><space> <plug>(lsp-document-symbol-search)
    " nnoremap <plug>(lsp-document-diagnostics)
    nmap <buffer> K <plug>(lsp-hover) " or <plug>(lsp-hover-preview)
    " nnoremap <plug>(lsp-next-diagnostic)
    " nnoremap <plug>(lsp-next-diagnostic-nowrap)
    " nnoremap <plug>(lsp-next-error)
    " nnoremap <plug>(lsp-next-error-nowrap)
    nmap <buffer> <C-n> <plug>(lsp-next-reference)
    " nnoremap <plug>(lsp-next-warning)
    " nnoremap <plug>(lsp-next-warning-nowrap)
    " nnoremap <plug>(lsp-preview-close)
    " nnoremap <plug>(lsp-preview-focus)
    " nnoremap <plug>(lsp-previous-diagnostic)
    " nnoremap <plug>(lsp-previous-diagnostic-nowrap)
    " nnoremap <plug>(lsp-previous-error)
    " nnoremap <plug>(lsp-previous-error-nowrap)
    " nnoremap <plug>(lsp-previous-reference)
    nmap <buffer> <C-p> <plug>(lsp-previous-reference)
    " nnoremap <plug>(lsp-previous-warning)
    " nnoremap <plug>(lsp-previous-warning-nowrap)
    " nnoremap <plug>(lsp-references)
    nmap <buffer> <S-F6> <plug>(lsp-rename)
    " nnoremap <plug>(lsp-workspace-symbol)
    nmap <buffer> <space>w <plug>(lsp-workspace-symbol-search)
    nmap <buffer> =- <plug>(lsp-document-format)
    " vnoremap <plug>(lsp-document-format)
    " nnoremap <plug>(lsp-document-range-format)
    " xnoremap <plug>(lsp-document-range-format)
    " nnoremap <plug>(lsp-implementation)
    " nnoremap <plug>(lsp-peek-implementation)
    " nnoremap <plug>(lsp-type-definition)
    nmap <buffer> <F2> <plug>(lsp-peek-type-definition)
    " nnoremap <plug>(lsp-type-hierarchy)
    " nnoremap <plug>(lsp-status)
    " nnoremap <plug>(lsp-signature-help)
    nmap <buffer> <F10> <plug>(lsp-code-action)
	nnoremap <buffer> <expr><c-down> lsp#scroll(+4)
	nnoremap <buffer> <expr><c-up> lsp#scroll(-4)

    " Commands {{{2
    command! CallHierarchyIncoming call lsp#ui#vim#call_hierarchy_incoming()
    command! CallHierarchyOutgoing call lsp#ui#vim#call_hierarchy_outgoing()
    command! -range -nargs=* -complete=customlist,lsp#ui#vim#code_action#complete CodeAction call lsp#ui#vim#code_action#do({
                \   'sync': v:false,
                \   'selection': <range> != 0,
                \   'query': '<args>'
                \ })
    command! -range -nargs=* -complete=customlist,lsp#ui#vim#code_action#complete CodeActionSync call lsp#ui#vim#code_action#do({
                \   'sync': v:true,
                \   'selection': <range> != 0,
                \   'query': '<args>'
                \ })
    command! CodeLens call lsp#ui#vim#code_lens#do({})
    command! Declaration call lsp#ui#vim#declaration(0, <q-mods>)
    command! PeekDeclaration call lsp#ui#vim#declaration(1)
    command! Definition call lsp#ui#vim#definition(0, <q-mods>)
    command! PeekDefinition call lsp#ui#vim#definition(1)
    command! DocumentSymbol call lsp#ui#vim#document_symbol()
    command! DocumentSymbolSearch call lsp#internal#document_symbol#search#do({})
    command! -nargs=? DocumentDiagnostics call lsp#internal#diagnostics#document_diagnostics_command#do(
                \ extend({}, lsp#utils#args#_parse(<q-args>, {
                    \   'buffers': {'type': type('')},
                    \ })))
    command! -nargs=? -complete=customlist,lsp#utils#empty_complete Hover call lsp#ui#vim#hover#get_hover_under_cursor()
    command! -nargs=* NextError call lsp#internal#diagnostics#movement#_next_error(<f-args>)
    command! -nargs=* PreviousError call lsp#internal#diagnostics#movement#_previous_error(<f-args>)
    command! -nargs=* NextWarning call lsp#internal#diagnostics#movement#_next_warning(<f-args>)
    command! -nargs=* PreviousWarning call lsp#internal#diagnostics#movement#_previous_warning(<f-args>)
    command! -nargs=* NextDiagnostic call lsp#internal#diagnostics#movement#_next_diagnostics(<f-args>)
    command! -nargs=* PreviousDiagnostic call lsp#internal#diagnostics#movement#_previous_diagnostics(<f-args>)
    command! References call lsp#ui#vim#references({})
    command! Rename call lsp#ui#vim#rename()
    command! TypeDefinition call lsp#ui#vim#type_definition(0, <q-mods>)
    command! TypeHierarchy call lsp#internal#type_hierarchy#show()
    command! PeekTypeDefinition call lsp#ui#vim#type_definition(1)
    command! -nargs=? WorkspaceSymbol call lsp#ui#vim#workspace_symbol(<q-args>)
    command! -nargs=? WorkspaceSymbolSearch call lsp#internal#workspace_symbol#search#do({'query': <q-args>})
    command! -range DocumentFormat call lsp#internal#document_formatting#format({ 'bufnr': bufnr('%') })
    command! -range -nargs=? DocumentFormatSync call lsp#internal#document_formatting#format(
                \ extend({'bufnr': bufnr('%'), 'sync': 1 }, lsp#utils#args#_parse(<q-args>, {
                    \   'timeout': {'type': type(0)},
                    \   'sleep': {'type': type(0)},
                    \ })))
    command! -range DocumentRangeFormat call lsp#internal#document_range_formatting#format({ 'bufnr': bufnr('%') })
    command! -range -nargs=? DocumentRangeFormatSync call lsp#internal#document_range_formatting#format(
                \ extend({'bufnr': bufnr('%'), 'sync': 1 }, lsp#utils#args#_parse(<q-args>, {
                    \   'timeout': {'type': type(0)},
                    \   'sleep': {'type': type(0)},
                    \ })))
    command! Implementation call lsp#ui#vim#implementation(0, <q-mods>)
    command! PeekImplementation call lsp#ui#vim#implementation(1)
    command! -nargs=0 Status call lsp#print_server_status()
    command! NextReference call lsp#internal#document_highlight#jump(+1)
    command! PreviousReference call lsp#internal#document_highlight#jump(-1)
    command! -nargs=? -complete=customlist,lsp#server_complete StopServer call lsp#ui#vim#stop_server(<f-args>)
    command! -nargs=? -complete=customlist,lsp#utils#empty_complete SignatureHelp call lsp#ui#vim#signature_help#get_signature_help_under_cursor()
    command! DocumentFold call lsp#ui#vim#folding#fold(0)
    command! DocumentFoldSync call lsp#ui#vim#folding#fold(1)
    command! -nargs=? SemanticScopes call lsp#ui#vim#semantic#display_scope_tree(<args>)

endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
