vim9script

# Shift + 矢印でウィンドウサイズを変更 
nnoremap <S-Left>  <C-w><
nnoremap <S-Right> <C-w>>
nnoremap <S-Up>    <C-w>-
nnoremap <S-Down>  <C-w>+

# Ctrl + hjklでウィンドウジャンプ 
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j

# Ctrl + 矢印でウィンドウジャンプ 
nnoremap <C-Left> <C-w>h
nnoremap <C-Right> <C-w>l
nnoremap <C-Up> <C-w>k
nnoremap <C-Down> <C-w>j

# line wrap 
# 表示行単位で上下移動するように
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap <Down> gj
nnoremap <Up>   gk

# Yの動作をDやCと同じにする 
map Y y$

# 英語キーボード最適化 
nnoremap ; :
nnoremap : ;

# Ctrl+c 二回押下でハイライト解除 
#nnoremap  <C-c><C-c> :<C-u>nohlsearch<cr><Esc>
nnoremap  <Esc><Esc> :<C-u>nohlsearch<cr><Esc>

# ESC最適化 
#imap <C-j> <esc>
inoremap jj <Esc>

# 日付を挿入 
inoremap <F2> <C-R>=strftime("%Y-%m-%d")<CR>
inoremap <F3> <C-R>=strftime("%H:%M")<CR>

# 検索後にジャンプした際に検索単語を画面中央に持ってくる 
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

# leaderを別キーにマッピング 
g:mapleader = "\<Space>"
g:maplocalleader = "\<Space>"

# tabnew 
nnoremap <C-t> :tabnew<CR>

# 閉じカッコの自動挿入 
inoremap {<CR> {<CR><CR>}<ESC><Up>i<Tab>
inoremap (<CR> (<CR><CR>)<ESC><Up>i<Tab>
inoremap () ()
inoremap ( ()<Left>
