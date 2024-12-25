set nocompatible
set background=dark
set termguicolors
filetype plugin indent on
syntax enable

" vimrc ファイルのディレクトリを取得
let s:vimrc_dir = fnamemodify(expand('$MYVIMRC'), ':h')

if filereadable(s:vimrc_dir . '/_plugins.vim')
  if empty(glob(s:vimrc_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo ' . s:vimrc_dir . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
  execute 'source ' . s:vimrc_dir . '/_plugins.vim'
endif

if filereadable(s:vimrc_dir . '/_general.vim')
  execute 'source ' . s:vimrc_dir . '/_general.vim'
endif

if filereadable(s:vimrc_dir . '/_keymaps.vim')
  execute 'source ' . s:vimrc_dir . '/_keymaps.vim'
endif

if filereadable(s:vimrc_dir . '/_filetypes.vim')
  execute 'source ' . s:vimrc_dir . '/_filetypes.vim'
endif

if filereadable(s:vimrc_dir . '/_functions.vim')
  execute 'source ' . s:vimrc_dir . '/_functions.vim'
endif

silent! colorscheme paper
set colorcolumn=130
set cursorline
set cursorlineopt=screenline
set nocursorcolumn

let g:terminal_ansi_colors = [
            \ '#484f58',
            \ '#ff5a4d',
            \ '#00ff7a',
            \ '#d2d722',
            \ '#58a6ff',
            \ '#bc8cff',
            \ '#39c5cf',
            \ '#b9dffe',
            \ '#6e7681',
            \ '#fdac54',
            \ '#79c0c0',
            \ '#c1be41',
            \ '#79c0ff',
            \ '#d2a8ff',
            \ '#56d4dd',
            \ '#d2ebfe',
            \ ]

if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    set grepformat=%f:%l:%m
endif
