vim9script

# Settings for girishji/vimcomplete
#
# TODO: enable vsnip and lsp

var options = {
    completor: { shuffleEqualPriority: true, postfixHighlight: true },
    buffer: { enable: true, priority: 10, urlComplete: true, envComplete: true },
    abbrev: { enable: true, priority: 10 },
    lsp: { enable: false, priority: 10, maxCount: 5 },
    omnifunc: { enable: false, priority: 8, filetypes: ['html', 'javascript'] },
    vsnip: { enable: false, priority: 11 },
    vimscript: { enable: true, priority: 11 },
    ngram: {
        enable: true,
        priority: 10,
        bigram: false,
        filetypes: ['text', 'help', 'markdown'],
        filetypesComments: ['c', 'cpp', 'python', 'java', 'go', 'vim'],
    },
}
autocmd VimEnter * g:VimCompleteOptionsSet(options)

