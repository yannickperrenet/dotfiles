""""""""""""""""""""""""""""""""""""""""""""""""""
" General helper functions module.
"
" For example in ftplugin files we can't define functions and instead
" put them here.
""""""""""""""""""""""""""""""""""""""""""""""""""
function! FollowMDLink()
    let line = getline('.')
    " \{-} means non-greedy match as to stop on first )
    let result = matchlist(line, '\[.*\](\(.\{-}\))')
    if len(result) == 0
        return
    endif
    " 0 is the full match and 1 is the submatch indicated by \(\)
    let link = result[1]
    if link =~ "^http[s]://"
        silent execute "!" .. g:netrw_browsex_viewer .. " '" .. link .. "'"
    else
        execute "e " .. expand('%:p:h') .. '/' .. link
    endif
endfunction
