vim9script

command! -nargs=0 ShortHash {
        var n: number = 8
        # if n > 32
        #     throw "Error: n must be less than 32"
        # endif
        var hash = system($"echo -n $(uuidgen | sha256sum | cut -c1-{n})")
        @* = hash
        echom hash
    }
