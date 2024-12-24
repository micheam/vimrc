set nocompatible
set background=dark
set termguicolors
filetype plugin indent on
syntax enable

if filereadable("_plugins.vim")
  if empty(glob('./autoload/plug.vim'))
    silent execute '!curl -fLo ./autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
  source _plugins.vim
endif

if filereadable("_general.vim")
  source _general.vim
endif

if filereadable("_keymaps.vim")
  source _keymaps.vim
endif

if filereadable("_filetypes.vim")
  source _filetypes.vim
endif

if filereadable("_functions.vim")
  source _functions.vim
endif

colorscheme paper
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
