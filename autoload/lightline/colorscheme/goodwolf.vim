" =============================================================================
" Filename: autoload/lightline/colorscheme/goodwolf.vim
" Description: Lightline colorscheme based on goodwolf.vim + ghostty goodwolf
" =============================================================================

" Goodwolf palette
let s:coal          = [ '#000000', 16  ]
let s:blackestgravel = [ '#141413', 232 ]
let s:blackgravel   = [ '#1c1b1a', 233 ]
let s:darkgravel    = [ '#242321', 235 ]
let s:deepergravel  = [ '#35322d', 236 ]
let s:deepgravel    = [ '#45413b', 238 ]
let s:gravel        = [ '#857f78', 243 ]
let s:lightgravel   = [ '#998f84', 245 ]
let s:brightgravel  = [ '#d9cec3', 252 ]
let s:plain         = [ '#b9dffe', 15  ]
let s:snow          = [ '#ffffff', 15  ]

" Accent colors
let s:lime          = [ '#baee00', 154 ]
let s:tardis        = [ '#0a9dff', 39  ]
let s:taffy         = [ '#ff2c4b', 196 ]
let s:orange        = [ '#ffa724', 214 ]
let s:dalespale     = [ '#fade3e', 221 ]
let s:dress         = [ '#ff9eb8', 211 ]
let s:saltwatertaffy = [ '#8cffba', 121 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

" Normal mode - lime green (matches GWStatusLineMode)
let s:p.normal.left = [ [ s:coal, s:lime ], [ s:plain, s:deepgravel ] ]
let s:p.normal.middle = [ [ s:brightgravel, s:darkgravel ] ]
let s:p.normal.right = [ [ s:coal, s:lime ], [ s:plain, s:deepgravel ] ]

" Insert mode - tardis blue (the cursor color)
let s:p.insert.left = [ [ s:coal, s:tardis ], [ s:plain, s:deepgravel ] ]
let s:p.insert.right = [ [ s:coal, s:tardis ], [ s:plain, s:deepgravel ] ]
let s:p.insert.middle = [ [ s:brightgravel, s:darkgravel ] ]

" Visual mode - orange
let s:p.visual.left = [ [ s:coal, s:orange ], [ s:plain, s:deepgravel ] ]
let s:p.visual.right = [ [ s:coal, s:orange ], [ s:plain, s:deepgravel ] ]
let s:p.visual.middle = [ [ s:brightgravel, s:darkgravel ] ]

" Replace mode - taffy red
let s:p.replace.left = [ [ s:snow, s:taffy ], [ s:plain, s:deepgravel ] ]
let s:p.replace.right = [ [ s:snow, s:taffy ], [ s:plain, s:deepgravel ] ]
let s:p.replace.middle = [ [ s:brightgravel, s:darkgravel ] ]

" Inactive
let s:p.inactive.left = [ [ s:gravel, s:deepergravel ], [ s:gravel, s:darkgravel ] ]
let s:p.inactive.middle = [ [ s:gravel, s:blackgravel ] ]
let s:p.inactive.right = [ [ s:gravel, s:deepergravel ], [ s:gravel, s:darkgravel ] ]

" Tabline
let s:p.tabline.left = [ [ s:brightgravel, s:deepgravel ] ]
let s:p.tabline.middle = [ [ s:lightgravel, s:darkgravel ] ]
let s:p.tabline.right = [ [ s:brightgravel, s:deepgravel ] ]
let s:p.tabline.tabsel = [ [ s:coal, s:tardis ] ]

" Error / Warning
let s:p.normal.error = [ [ s:coal, s:taffy ] ]
let s:p.normal.warning = [ [ s:coal, s:dalespale ] ]

let g:lightline#colorscheme#goodwolf#palette = lightline#colorscheme#flatten(s:p)
