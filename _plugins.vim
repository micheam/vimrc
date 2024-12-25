vim9script

const vimrc_dir = fnamemodify(expand('$MYVIMRC'), ':h')

plug#begin(vimrc_dir .. "/plugged") 

# General 
Plug "machakann/vim-sandwich" | nmap s <Nop> ; xmap s <Nop>
Plug "justinmk/vim-dirvish"
Plug "chrisbra/NrrwRgn"
Plug "t9md/vim-choosewin" | nmap <space>` <Plug>(choosewin)
Plug "guns/vim-sexp" | Plug "tpope/vim-sexp-mappings-for-regular-people"
g:sexp_enable_insert_mode_mappings = 1
g:sexp_filetypes = "clojure,scheme,lisp,timl"

Plug "/Users/micheam/ghq/github.com/micheam/vim-hardwrap"
Plug "tpope/vim-commentary"
Plug "godlygeek/tabular"
Plug "thinca/vim-quickrun"
nnoremap [quickrun] <Nop>
nmap     <Space>r [quickrun]
nnoremap <silent> [quickrun]   :<C-u>QuickRun<CR>
nnoremap <silent> [quickrun]a  :<C-u>QuickRun --args
g:quickrun_config = {
    "_": {
      "runmode": "async:remote:vimproc",
      "split": "below 5"
    },
    "markdown": {
      "type": "markdown/pandoc",
      "cmdopt": "-s",
      "outputter": "browser",
    },
  }
Plug "tyru/open-browser.vim"
Plug "mattn/webapi-vim"
Plug "mattn/vim-sonictemplate" | Plug "micheam/vim-sonictemplate-template"
g:sonictemplate_vim_template_dir = [
  $HOME .. "/.vim/plugged/vim-sonictemplate-template/template",
  $HOME .. "/.vim/plugged/vim-sonictemplate/template",
  $HOME .. "/dotfiles/vim/template"
]
g:sonictemplate_vim_vars = { "_": { "author": "Michto Maeda" } }
imap <C-j> <C-r>=sonictemplate#expand()<CR>

Plug "h1mesuke/vim-alignta"
Plug "majutsushi/tagbar" | g:tagbar_left = 1 | g:tagbar_show_linenumbers = 1 | g:tagbar_type_proto = {
  "kinds": [
    "p:packages:0:0",
    "m:messages:0:0",
    "f:fields:1:0",
    "e:enum constants:0:0",
    "g:enum types:0:0",
    "s:services:0:0",
  ]}
Plug "junegunn/fzf", { "do": "./install --all" } | Plug "junegunn/fzf.vim"
set rtp+=/usr/local/opt/fzf
set rtp+=/opt/homebrew/opt/fzf
command! -bang -nargs=* Ag call fzf#vim#ag("", <bang>0 ? fzf#vim#with_preview("up:60%"): fzf#vim#with_preview("right:50%:hidden", "?"), <bang>0)
nnoremap <space>b :Buffers<CR>
nnoremap <space>f :Files<CR>
nnoremap <space>g :Ag<CR>

Plug "junegunn/goyo.vim"
Plug "junegunn/limelight.vim" | autocmd! User goyo.vim echom "Goyo is now loaded!"
Plug "sheerun/vim-polyglot"
Plug "prettier/vim-prettier", {"do": "npm install --frozen-lockfile --omit=dev", "for": ["javascript", "typescript", "css", "less", "scss", "json", "graphql", "markdown", "vue", "svelte", "yaml", "html"] }

# Colorscheme
Plug "micheam/vim-paper"
Plug "cocopon/iceberg.vim"

# Status line 
Plug "itchyny/lightline.vim" | set laststatus=2
 
# Git 
Plug "cohama/agit.vim"
Plug "rhysd/committia.vim"
Plug "tpope/vim-fugitive"
Plug "tpope/vim-rhubarb"
Plug "airblade/vim-gitgutter"
Plug "mattn/gist-vim"
Plug "koizuss/shareline.vim"
 
# shell 
Plug "vim-scripts/awk-support.vim"  , {"for": "awk"}
Plug "mechatroner/rainbow_csv"      , {"for": ["csv", "tsv"]}
g:rbpt_colorpairs = [
  ["darkyellow",  "RoyalBlue3"],
  ["darkgreen",   "SeaGreen3"],
  ["darkcyan",    "DarkOrchid3"],
  ["Darkblue",    "firebrick3"],
  ["DarkMagenta", "RoyalBlue3"],
  ["darkred",     "SeaGreen3"],
  ["darkyellow",  "DarkOrchid3"],
  ["darkgreen",   "firebrick3"],
  ["darkcyan",    "RoyalBlue3"],
  ["Darkblue",    "SeaGreen3"],
  ["DarkMagenta", "DarkOrchid3"],
  ["Darkblue",    "firebrick3"],
  ["darkcyan",    "SeaGreen3"],
  ["darkgreen",   "RoyalBlue3"],
  ["darkyellow",  "DarkOrchid3"],
  ["darkred",     "firebrick3"],
]
g:rbpt_max = 16
g:rbpt_loadcmd_toggle = 0


 
# docs 
Plug "vim-jp/vimdoc-ja"
 
# other 
Plug "previm/previm", {"for": ["markdown", "rst"]} | g:rst_style = 1
g:previm_disable_default_css = 1
g:previm_enable_realtime = 1
g:previm_open_cmd = "open -a Firefox"
g:previm_custom_css_path = $HOME .. "/dotfiles/vim/misc/previm.css"
g:previm_extra_libraries = [
  {
    "name": "katex",
    "files": [
      {
        "type": "css",
        "path": "_/js/extra/texmath.min.css",
        "url": "https://cdn.jsdelivr.net/npm/markdown-it-texmath/css/texmath.min.css",
      },
      {
        "type": "css",
        "path": "_/css/extra/katex.min.css",
        "url": "https://cdn.jsdelivr.net/npm/katex@latest/dist/katex.min.css",
        "code": [
          "renderMathInElement(document.body)",
        ],
      },
      {
        "type": "js",
        "path": "_/js/extra/katex-auto-render.min.js",
        "url": "https://cdn.jsdelivr.net/npm/katex@latest/dist/contrib/auto-render.min.js",
        "code": [ "renderMathInElement(document.body)" ],
      },
      {
        "type": "font",
        "path": "_/css/extra/fonts/KaTeX_Main-Regular.ttf",
        "url": "https://raw.githubusercontent.com/KaTeX/KaTeX/main/fonts/KaTeX_Main-Regular.ttf",
      },
      {
        "type": "font",
        "path": "_/css/extra/fonts/KaTeX_Main-Regular.woff",
        "url": "https://raw.githubusercontent.com/KaTeX/KaTeX/main/fonts/KaTeX_Main-Regular.woff",
      },
      {
        "type": "font",
        "path": "_/css/extra/fonts/KaTeX_Main-Regular.woff2",
        "url": "https://raw.githubusercontent.com/KaTeX/KaTeX/main/fonts/KaTeX_Main-Regular.woff2",
      },
      {
        "type": "font",
        "path": "_/css/extra/fonts/KaTeX_Math-Italic.ttf",
        "url": "https://raw.githubusercontent.com/KaTeX/KaTeX/main/fonts/KaTeX_Math-Italic.ttf",
      },
      {
        "type": "font",
        "path": "_/css/extra/fonts/KaTeX_Math-Italic.woff",
        "url": "https://raw.githubusercontent.com/KaTeX/KaTeX/main/fonts/KaTeX_Math-Italic.woff",
      },
      {
        "type": "font",
        "path": "_/css/extra/fonts/KaTeX_Math-Italic.woff2",
        "url": "https://raw.githubusercontent.com/KaTeX/KaTeX/main/fonts/KaTeX_Math-Italic.woff2",
      },
      {
        "type": "font",
        "path": "_/css/extra/fonts/KaTeX_Size2-Regular.ttf",
        "url": "https://raw.githubusercontent.com/KaTeX/KaTeX/main/fonts/KaTeX_Size2-Regular.ttf",
      },
      {
        "type": "font",
        "path": "_/css/extra/fonts/KaTeX_Size2-Regular.woff",
        "url": "https://raw.githubusercontent.com/KaTeX/KaTeX/main/fonts/KaTeX_Size2-Regular.woff",
      },
      {
        "type": "font",
        "path": "_/css/extra/fonts/KaTeX_Size2-Regular.woff2",
        "url": "https://raw.githubusercontent.com/KaTeX/KaTeX/main/fonts/KaTeX_Size2-Regular.woff2",
      },
      {
        "type": "font",
        "path": "_/css/extra/fonts/KaTeX_Size3-Regular.ttf",
        "url": "https://raw.githubusercontent.com/KaTeX/KaTeX/main/fonts/KaTeX_Size3-Regular.ttf",
      },
      {
        "type": "font",
        "path": "_/css/extra/fonts/KaTeX_Size3-Regular.woff",
        "url": "https://raw.githubusercontent.com/KaTeX/KaTeX/main/fonts/KaTeX_Size3-Regular.woff",
      },
      {
        "type": "font",
        "path": "_/css/extra/fonts/KaTeX_Size3-Regular.woff2",
        "url": "https://raw.githubusercontent.com/KaTeX/KaTeX/main/fonts/KaTeX_Size3-Regular.woff2",
      },
      {
        "type": "js",
        "path": "_/js/extra/katex.min.js",
        "url": "https://cdn.jsdelivr.net/npm/katex@latest/dist/katex.min.js",
        "code": [
          "document.querySelectorAll(\"pre code.language-katex\").forEach(elem => {",
          "  const html = katex.renderToString(elem.innerText, {",
          "    displayMode: true,",
          "    output: \"html\",",
          "    throwOnError: false,",
          "  })",
          "  const span = document.createElement(\"span\")",
          "  span.innerHTML = html",
          "  elem.parentNode.replaceWith(span)",
          "})",
          "document.querySelectorAll(\".inlkatex\").forEach(elem => {",
          "  const html = katex.renderToString(elem.innerText, {",
          "    output: \"html\",",
          "    throwOnError: false,",
          "  })",
          "  const span = document.createElement(\"span\")",
          "  span.innerHTML = html",
          "  elem.replaceWith(span)",
          "})",
        ],
      },
    ],
  },
]


Plug "diepm/vim-rest-console" | g:vrc_curl_opts = {
    "--connect-timeout": 10,
    "--location": '',
    "-i": '',
    "--max-time": 60,
    "-k": '',
    "--silent": '',
  }

g:vrc_auto_format_response_patterns = {
  "json": "jq .",
  "xml": "xmllint --format -",
}

Plug "aklt/plantuml-syntax"
Plug "vim-scripts/nginx.vim"
Plug "rbtnn/vim-coloredit"
 
# SQL 
Plug "vim-scripts/SQLUtilities"
Plug "vim-scripts/Align"
 
# markdown 
Plug "iamcco/markdown-preview.vim"                 , {"for": "markdown"}
Plug "rhysd/vim-gfm-syntax"                        , {"for": "markdown"} # TODO: README.md にだけ効かせた方が良いかな？
g:gfm_syntax_emoji_conceal = 1
g:markdown_fenced_languages = ["json", "sql", "uml=plantuml", "yaml", "diff", "go", "sh", "shell=sh", "bash=sh", "clojure", "scheme", "proto"]
Plug "micheam/vim-markdown-support"                , {"for": "markdown"}
 
# yaml 
Plug "avakhov/vim-yaml"
 
# JavaScript 
Plug "othree/yajs.vim"                        , {"for": ["javascript" , "javascript.jsx"]}
Plug "othree/es.next.syntax.vim"              , {"for": ["javascript" , "javascript.jsx"]}
Plug "othree/javascript-libraries-syntax.vim" , {"for":["javascript","javascript.jsx"]}
Plug "quramy/tsuquyomi"                       , {"for": "typescript"}
Plug "leafgarland/typescript-vim"             , {"for": "typescript"}
 
# Html 
Plug "alvan/vim-closetag"
Plug "mattn/emmet-vim"
 
# Go言語 
Plug "buoto/gotests-vim"   , {"for": "go"}
Plug "vim-jp/vim-go-extra" , {"for": "go"}
Plug "mattn/vim-goimports" , {"for": "go"}
Plug "mattn/vim-gotmpl" | g:goimports_local = "micheam.com,github.com/micheam,finswer"

# C/C++
Plug "rhysd/vim-clang-format" , {"for": ["c", "cpp"]}

# Rust
Plug "rust-lang/rust.vim" | g:rust_clip_command = "pbcopy"

# Zig
Plug "ziglang/zig.vim"

# gotags
# check if gotags command exists
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
else
    echo "gotags command not found. Please install gotags command."
endif

Plug "micheam/vim-go-test", {"for": "go", "branch": "develop"}
g:force_reload_go_test = 1
g:go_test_vervose = v:true
g:go_test_enable_default_key_mappings = v:true

# Dart 
Plug "dart-lang/dart-vim-plugin"
g:dart_format_on_save = 1
 
# Language Server Protocol 
Plug "prabirshrestha/asyncomplete.vim"
Plug "prabirshrestha/vim-lsp"
Plug "prabirshrestha/asyncomplete-lsp.vim"
 
# Clojure 
#Plug "guns/vim-clojure-static"             , {"for": "clojure"}
#Plug "kien/rainbow_parentheses.vim"        , {"for": "clojure"}
#Plug "guns/vim-clojure-highlight"          , {"for": "clojure"}
#Plug "tpope/vim-fireplace"                 , {"for": "clojure"}
#Plug "venantius/vim-cljfmt"                , {"for": "clojure"}
Plug "liquidz/vim-iced"                    , {"for": "clojure"}
g:iced_enable_default_key_mappings = v:true
Plug "liquidz/vim-iced-project-namespaces" , {"for": "clojure"}
Plug "liquidz/vim-iced-function-list"      , {"for": "clojure"}

# Vimscript 
Plug "vim-jp/vital.vim"

# Kotlin 
Plug "udalov/kotlin-vim"

# protobuf 
Plug "uarun/vim-protobuf"
Plug "micheam/vim9-bufbuild" | g:bufbuild_enable_command = 1

# misc 
Plug "fladson/vim-kitty"
Plug "vim-scripts/BufOnly.vim"
Plug "github/copilot.vim" | g:copilot_filetypes = { "proto": true, "markdown": true }
Plug "tyru/capture.vim"

#Plug "itchyny/vim-qfedit"
#Plug "thinca/vim-qfreplace"
 
Plug "micheam/ai-assistant-console"
Plug "micheam/select-node"

plug#end()
