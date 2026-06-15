vim9script

# YAML frontmatter の popup 表示 (autoload/frontmatter.vim)

import autoload 'frontmatter.vim'

command! -buffer FrontmatterShow frontmatter.Show()
command! -buffer FrontmatterClose frontmatter.Close()
command! -buffer FrontmatterToggle frontmatter.Toggle()
nnoremap <buffer> <space>m <ScriptCmd>frontmatter.Toggle()<CR>

# AutoPopupDisplay が有効かつ frontmatter が存在する場合に自動表示する。
if frontmatter.AutoPopupEnabled() && frontmatter.Exists()
    frontmatter.Show()
endif
