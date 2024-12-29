vim9script

# if $TERM =~ "kitty"
#     " Insert / Normal でカーソルを切り替える
#     let &t_SI = "\<Esc>[6 q"
#     let &t_SR = "\<Esc>[4 q"
#     let &t_EI = "\<Esc>[2 q"
#     set t_ut =
# 
#     " xterm-bracketed-paste
#     let &t_BE = "\e[?2004h"
#     let &t_BD = "\e[?2004l"
#     exec "set t_PS=\e[200~"
#     exec "set t_PE=\e[201~"
# endif

set shell=bash
set helplang=ja,en
set hlsearch
set incsearch
set noswapfile
set hidden
set tabstop=4
set shiftwidth=4
set expandtab
set wrap
set listchars=tab:»-,trail:.,eol:$
set nrformats-=octal
set foldmarker={{{,}}}
set foldmethod=marker
set scrolloff=3
set signcolumn=number
set number

# grep後に自動でQuickFixWindowを開く 
autocmd QuickfixCmdPost make,grep,vimgrep belowright cwindow

# エンコード設定 
set fileencodings=ucs-bom,utf-8,iso-2022-jp,sjis,cp932,euc-jp,cp20932

# クリップボードを使用する 
set clipboard^=unnamed,unnamedplus

# 自動改行 textwide 
set textwidth=0

# 対応括弧に'<'と'>'のペアを追加 
set matchpairs& matchpairs+=<:>
set virtualedit=all     # カーソルを文字が存在しない部分でも動けるようにする

# set mune off 
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b

# spell check
set spelllang=en,cjk
set nospell
