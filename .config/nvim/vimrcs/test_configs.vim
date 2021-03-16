" Show line numbers, allows for faster movement inside file.
set relativenumber

" Linebreak on 100 characters
set tw=100

" Great for Python or structuring note taking
if has('folding')
    set foldmethod=indent
    set foldnestmax=3
    " If zero, all folds are closed.
    set foldlevelstart=3
endif

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

" Enable mouse
set mouse=a

" Show [text link](link to something) as text link
"set conceallevel=2

" cursorline
hi CursorLine cterm=NONE ctermbg=darkblue
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

" Preview window settings.
set completeopt=menu,menuone,noinsert,noselect
set previewheight=10
set splitbelow

" set signcolumn=yes
set numberwidth=1

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

" Otherwise the linting might trigger and 'de-trigger' the
" signcolumn 24/7, making the screen go from left to right
" to left to right to left....
set signcolumn=yes

" Use Esc in terminal to enter normal mode. This does interfere
" with the vi-mode from zsh, but this does not matter as it has
" the exact same functionality.
tnoremap <Esc> <C-\><C-n>

" Switch between last opened buffers. This is easier to press.
nnoremap <C-s> <C-^>

" Switch between last accessed window
nnoremap <leader>p <C-w>p

" Set window title of terminal (used for searching open windows)
set title
set titlestring=Nvim:\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)%(\ (%{getcwd()})%)

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
