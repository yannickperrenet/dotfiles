" :W --> sudo saves the file. Useful for permission-denied errors.
command W w !sudo tee % > /dev/null

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

" Return to last edit position when opening files (You want this!)
" When starting to edit an existing file (any filetype), do:
" - line("'\"") gets the line number of the cursor position when last
"   exiting the current buffer.
"   - 'x get position of mark x
"   - \" means the mark " which is the cursor position when last exiting
"     the current buffer
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Delete trailing white space on save
autocmd BufWritePre * :call CleanExtraSpaces()

" Always show the cursorline on the line with the cursor.
" When using multiple windows, only the window with the cursor should
" show the cursorline. On buffer switch, the cursorline should be removed
" from the previous buffer and drawn at the next buffer.
augroup CursorLine
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" NOTE: You might want to disable this as `:mkview` is not very efficient
" Make fold configuration persistent as long as the file is within buffers.
" Can be configured what is (re)stored using `viewoptions`.
" NOTE: It also doesn't work all that great.
" augroup AutoSaveFolds
"   autocmd!
"   autocmd BufWinLeave *.py mkview!
"   autocmd BufWinEnter * silent! loadview
" augroup END

""""""""""""""""""""""""""""""
" => Helper functions
""""""""""""""""""""""""""""""
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    " If there is an alternate buffer then go there
    if buflisted(l:alternateBufNum)
        buffer #
    " else go to the next buffer
    else
        bnext
    endif

    " If we are still at the same buffer, then show an empty buffer
    if bufnr("%") == l:currentBufNum
        new
    endif

    " Delete the buffer we wanted to delete
    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction
