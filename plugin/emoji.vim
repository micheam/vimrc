" if emoji#available()
"   let g:gitgutter_sign_added = emoji#for('small_red_triangle')
"   let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
"   let g:gitgutter_sign_removed = emoji#for('small_blue_diamond')
"   let g:gitgutter_sign_modified_removed = emoji#for('collision')
" endif

" C-x C-u を絵文字保管に切り替える
function! s:ToggleComplete()
  if &completefunc == 'emoji#complete' && exists('g:emoji_complete_bak')
    let &completefunc = g:emoji_complete_bak
    echomsg printf("change completefunc. 'emoji#complete' -> '%s'", g:emoji_complete_bak)
    unlet g:emoji_complete_bak
  else
    let g:emoji_complete_bak = &completefunc
    let &completefunc = "emoji#complete"
    echomsg printf("change completefunc. '%s' -> 'emoji#complete'", g:emoji_complete_bak)
  endif
endfunction
command! EmojiCompleteToggle :call s:ToggleComplete()

" カレントバッファの :emoji_name: を絵文字に変換する
function! s:Replace()
  %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g
endfunction
command! EmojiReplaceAll :call s:Replace()


