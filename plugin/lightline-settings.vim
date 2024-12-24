let g:lightline = {
            \ 'colorscheme': 'PaperColor',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], [ 'package' ] ],
            \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'component_function': {
            \   'fugitive': 'LightlineFugitive',
            \   'filename': 'LightlineFilename',
            \   'fileformat': 'LightlineFileformat',
            \   'filetype': 'LightlineFiletype',
            \   'fileencoding': 'LightlineFileencoding',
            \   'mode': 'LightlineMode',
            \   'package': 'LightlinePackage',
            \ },
            \ 'component_expand': {
            \   'syntastic': 'SyntasticStatuslineFlag',
            \ },
            \ 'component_type': {
            \   'syntastic': 'error',
            \ },
            \ 'subseparator': { 'left': '|', 'right': '|' }
            \ }

function! LightlineModified()
    return &ft ==# 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
    return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
    let fname = expand('%:t')
    return fname ==# 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
                \ fname =~# '^__Tagbar__\|__Gundo\|NERD_tree' ? '' :
                \ (LightlineReadonly() !=# '' ? LightlineReadonly() . ' ' : '') .
                \ (fname !=# '' ? fname : '[No Name]') .
                \ (LightlineModified() !=# '' ? ' ' . LightlineModified() : '')
endfunction

function! LightlinePackage()
    if exists('b:package')
        return b:package
    endif 
    try
        let pkg = go#package()
        let b:package = pkg
        return pkg
    catch
    endtry
    return ''
endfunction

function! LightlineFugitive()
    try
        if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && exists('*FugitiveHead')
            let mark = ''  " edit here for cool mark
            let branch = FugitiveHead()
            return branch !=# '' ? mark.branch : ''
        endif
    catch
    endtry
    return ''
endfunction

function! LightlineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
    return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
    let fname = expand('%:t')
    return fname =~# '^__Tagbar__' ? 'Tagbar' :
                \ fname ==# '__Gundo__' ? 'Gundo' :
                \ fname ==# '__Gundo_Preview__' ? 'Gundo Preview' :
                \ fname =~# 'NERD_tree' ? 'NERDTree' :
                \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    return lightline#statusline(0)
endfunction

