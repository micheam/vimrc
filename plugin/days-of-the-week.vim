" day-of-the-week
" Version: 0.0.1
" Last Change:	2020-08-13.
" Author: michito.maeda
" GitHub: https://github.com/micheam
" License: MIT

if exists('g:loaded_DaysOfTheWeek')
  finish
endif
let g:loaded_DaysOfTheWeek = 1

let s:save_cpo = &cpo
set cpo&vim

function! DaysOfTheWeek() 
    echom 'Monday      Mon.'
    echom 'Tuesday     Tue.'
    echom 'Wednesday   Wed.'
    echom 'Thursday    Thu.'
    echom 'Friday      Fri.'
    echom 'Saturday    Sat.'
endfunction
command! DaysOfTheWeek :call DaysOfTheWeek()

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
