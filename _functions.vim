vim9script

# カーソル下のhighlight情報を表示する 
def GetSynID(transparent: bool): number
    const synid = synID(line('.'), col('.'), 1)
    return transparent ? synIDtrans(synid) : synid
enddef

def GetSynName(synid: number): string
    return synIDattr(synid, "name")
enddef

def GetHighlightInfo(): void
    execute "highlight " .. GetSynName(GetSynID(false))
    execute "highlight " .. GetSynName(GetSynID(true))
enddef

command! HighlightInfo call GetHighlightInfo()
command! HighlightGroupUnderCur echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")

defcompile
