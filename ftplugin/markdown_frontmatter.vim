vim9script

# YAML frontmatter の popup 表示 (autoload/frontmatter.vim)

import autoload 'frontmatter.vim'

command! -buffer FrontmatterShow frontmatter.Show()
command! -buffer FrontmatterClose frontmatter.Close()
command! -buffer FrontmatterToggle frontmatter.Toggle()
nnoremap <buffer> <space>m <ScriptCmd>frontmatter.Toggle()<CR>
