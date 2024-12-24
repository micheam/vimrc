vim9script

setlocal autoindent
setlocal cursorcolumn
setlocal expandtab
setlocal shiftwidth=2
setlocal smartindent
setlocal softtabstop=2
setlocal tabstop=2

# Syntax Highlighting and Folding:
#
# Enabling syntax highlighting can significantly improve readability.
# Additionally, setting up code folding based on indentation can help
# manage large YAML files.
syntax enable
set foldmethod=indent
set foldlevelstart=99

# Prevent Unwanted Spaces:
#
# YAML is sensitive to spaces and tabs, so ensuring that no unwanted
# tabs are inserted is crucial.
setlocal nolist  # Hide tabs and trailing spaces visually
setlocal nowrap  # Disable line wrapping

# Search Settings:
#
# Enhancing search functionality can help navigate YAML files more effectively.
setlocal ignorecase  # Search case insensitively
setlocal smartcase   # Search case sensitively if the query contains uppercase letters

# Backup Settings:
#
# Avoid creating swap and backup files that could clutter your directories
# or interfere with version control systems.
setlocal nobackup
setlocal noswapfile

# Auto Commands:
#
# Automatically strip trailing whitespace on save, which can prevent
# syntax errors in YAML files.
autocmd! BufWritePre *.yaml {
  :%s/\s\+$//e
}

# Line Numbering:
#
# Having line numbers can be helpful when debugging or referencing specific
# parts of your YAML files.
setlocal number
