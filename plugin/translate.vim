vim9script noclear    
# Vim global plugin for translating current documents
# Last Change:	2021 Dec 30
# Maintainer:	Michito Maeda <michito.maeda@gmail.com>

if exists("g:loaded_translate") && g:loaded_translate == 1
    echom "translate already loaded"
    finish
endif
g:loaded_translate = 0

def Line(start: number, stop: number, target = ""): void
    var cmd = "! translate"
    if target != ""
        cmd = cmd .. " -target " .. target
    endif
    execute ":" .. start .. "," .. stop .. cmd
enddef

nnoremap <Leader>tll :<C-U>execute('call <SID>Line(' .. line('.') .. ', ' .. line('.') .. ')')<CR>
xnoremap <Leader>tll :<C-U>execute('call <SID>Line(' .. line("'<") .. ', ' .. line("'>") .. ')')<CR>

if !exists(":TranslateLine")
    command -nargs=? -range TranslateLine call <SID>Line(<line1>, <line2>, <f-args>)
endif
