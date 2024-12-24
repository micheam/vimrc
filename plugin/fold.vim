" Support Foldings
vim9script 
command FoldAllButCurrent {
        :normal! zMzO
    }

nnoremap <silent> <leader>z :FoldAllButCurrent<CR>

