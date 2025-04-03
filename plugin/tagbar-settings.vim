vim9script

# Tagbar settings
g:tagbar_position = 'aboveleft'
g:tagbar_show_linenumbers = 0

# Tagbar keymapping
#noop

# Custom Commands
command! -nargs=0 TagJump {
    # show the tagbar window and autoclose on jump
    call tagbar#OpenWindow('fjc')
    }

# Tagbar type for protobuf
g:tagbar_type_proto = {
  "kinds": [
    "p:packages:0:0",
    "m:messages:0:0",
    "f:fields:1:0",
    "e:enum constants:0:0",
    "g:enum types:0:0", 
    "s:services:0:0",
  ]
}

# Tagbar type for go
if executable("gotags")
  g:tagbar_type_go = {
    "ctagstype": "go",
    "kinds": [
      "p:package",
      "i:imports:1",
      "c:constants",
      "v:variables",
      "t:types",
      "n:interfaces",
      "w:fields",
      "e:embedded",
      "m:methods",
      "r:constructor",
      "f:functions"
    ],
    "sro": ".",
    "kind2scope": {
      "t": "ctype",
      "n": "ntype"
    },
    "scope2kind": {
      "ctype": "t",
      "ntype": "n"
    },
    "ctagsbin": "gotags",
    "ctagsargs": "-sort -silent"
  }
endif

# Warning for missing gotags in Go files
augroup TagbarGoWarning
  autocmd!
  autocmd FileType go if !executable('gotags') | echohl WarningMsg | echo "gotags command not found. Please install gotags for better Go support in Tagbar." | echohl None | endif
augroup END
