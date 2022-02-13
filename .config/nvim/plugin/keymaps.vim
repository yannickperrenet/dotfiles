""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
" map <space> /

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Quickly open a buffer for scribble
map <leader>q :e $XDG_DATA_HOME/nvim/buffer_scribble<cr>

" Close the current buffer
" map <leader>bc :Bclose<cr>:tabclose<cr>gT

" Close the current buffer whilst trying to maintain the current split
" It simply goes to the previous buffer and closes the currently open one
" map <leader>bc :bp|bd#<cr>

" Close all the buffers
" map <leader>ba :bufdo bd<cr>

" Cycle through buffers
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    " autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
    autocmd BufWritePre * :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Respectively: go to next misspelled word, previous, add to
" dictionary, fix
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>sf z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle paste mode on and off
map <leader>P :setlocal paste!<cr>

" Copy file content to clipboard
if has("mac") || has("macunix")
    nmap <silent> <leader>cf :! pbcopy < %<CR>
elseif has("unix")
    nmap <silent> <leader>cf :! cat % \| xclip -selection c<CR>
endif

" When a sentence spans multiple lines, show a special character for the break
" and color this character the same as the line numbers
" set showbreak=\ \ ↳

" Color entire viewport, not just the rows with text
hi! link NonText LineNr

" Open the definition in a vertical split
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Yank selection to clipboard
vnoremap <leader>y "+y

augroup CursorLine
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END
function! BlinkCursorline()
    set cursorline!
    redraw
    sleep 100m
    set cursorline!
endfunction
nnoremap <leader>c :call BlinkCursorline()<CR>

" Make fold configuration persistent as long as the file is within buffers
" augroup AutoSaveFolds
"   autocmd!
"   autocmd BufWinLeave * mkview
"   autocmd BufWinEnter * silent loadview
" augroup END

" Press `gx` to open the file under the cursor. This actually works by
" using netrw (which is installed by default).
let g:netrw_browsex_viewer="xdg-open"
if !has('nvim')
    " In Vim there is an issue:
    "   https://github.com/vim/vim/issues/4738
    " This mapping gives more or less the same behavior.
    nmap gx yiW:!xdg-open <cWORD><CR> <C-r>" & <CR><CR>
endif

" Use Esc in terminal to enter normal mode. This does interfere
" with the vi-mode from zsh, but this does not matter as it has
" the exact same functionality.
tnoremap <Esc> <C-\><C-n>

" Switch between last opened buffers. This is easier to press.
nnoremap <C-s> <C-^>

" Switch between last accessed window
nnoremap <leader>p <C-w>p

nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprev<CR>
nnoremap <C-q> :call QFixToggle()<CR>

" https://vim.fandom.com/wiki/Toggle_to_open_or_close_the_quickfix_window
function! QFixToggle()
  if exists("g:qfix_win")
    cclose
    unlet g:qfix_win
  else
    copen
    let g:qfix_win = bufnr("$")
  endif
endfunction

" Set ' mark on "k" and "j" movements if they are jumping multiple lines
" to emulate populating the jumplist.
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" Moving visually selected text around with proper indentation
vnoremap <Up> :m '<-2<CR>gv=gv
vnoremap <Down> :m '>+1<CR>gv=gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
