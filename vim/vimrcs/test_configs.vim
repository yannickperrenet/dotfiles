" Show line numbers, allows for faster movement inside file.
set relativenumber

" Linebreak on 100 characters
set tw=100

" Great for Python or structuring note taking
if has('folding')
    set foldmethod=indent
    set foldlevelstart=1
endif

" Copy file content to clipboard
if has("mac") || has("macunix")
    nmap <silent> <leader>cf :! pbcopy < %<CR>
elseif has("unix")
    nmap <silent> <leader>cf :! cat % \| xclip -selection c<CR>
endif

" When a sentence spans multiple lines, show a special character for the break
" and color this character the same as the line numbers
set showbreak=\ \ ↳\ 
hi! link NonText LineNr

" Generate a tags file for your current working directory and
" activated virtual environment
map <leader>g :!ctags --tag-relative=yes --languages=python -R -f $VIRTUAL_ENV/tags . $VIRTUAL_ENV/lib/python3.7/site-packages<CR>
set tags=$VIRTUAL_ENV/tags
" Open the definition in a vertical split
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Yank selection to clipboard
vnoremap <leader>y "+y

" Enable mouse
set mouse=a

" Show [text link](link to something) as text link
"set conceallevel=2

" Toggle cursorline on and off. The autocommand makes it such that the
" cursorline is only shown in the current window.
hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
nnoremap <leader>c :set cursorline!<CR>
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal nocursorline
  au WinLeave * setlocal nocursorline
augroup END

" Preview window settings.
set completeopt=menu,menuone,preview
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
