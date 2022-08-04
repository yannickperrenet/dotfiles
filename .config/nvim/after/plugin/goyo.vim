map <leader>g :call ToggleGoyo()<CR>
let g:goyo_linenr = 1

function! ToggleGoyo()
    if exists('#goyo')
        execute "Goyo!"
        return
    endif

    " X-offset can only be specified as an argument, not as a variable.
    execute "Goyo 100+10x85%"
endfunction
