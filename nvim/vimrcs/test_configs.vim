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
function! BlinkCursorline()
    set cursorline!
    redraw
    sleep 100m
    set cursorline!
endfunction
hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
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
