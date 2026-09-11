vim9script

import autoload 'diff_apply.vim'

command! -range -bang -nargs=? DiffApply
      \ diff_apply.Apply(<line1>, <line2>, <range>, <bang>false, <q-args>)
