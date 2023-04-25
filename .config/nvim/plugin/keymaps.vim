" Fast saving
nmap <leader>w :w!<cr>
" Super useful when editing files in the same directory
map <leader>e :e <c-r>=expand("%:p:h")<cr>/
" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>
" Reload vim config by reloading all matched patterns when
" searching `runtimepath` and `packpath`
nnoremap <leader>r :runtime! init.vim plugin/** after/plugin/** after/ftplugin/**<cr>

" Yank selection to clipboard
vnoremap <leader>y "+y

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" Switch between last accessed window
nnoremap <C-p> <C-w>p

" Quickfix window
nnoremap <leader>n :cnext<CR>
nnoremap <leader>p :cprev<CR>
nnoremap <C-q> :call QFixToggle()<CR>

" Quickly open a buffer for scribble
map <leader>q :e $XDG_DATA_HOME/nvim/buffer_scribble<cr>

" Open my (personal) docs: [Z]ettelkasten
map <leader>z :e ~/.local/share/vimwiki/docs/index.md<cr>
" Serve my personal docs in the background: [Z]ettelkasten [S]erve
map <leader>zs :call system("mkdocs serve -f ~/.local/share/vimwiki/mkdocs.yml &")<cr>

" Close the current buffer but maintain window layout
map <leader>bc :Bclose<cr>

" Cycle through buffers
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Switch between last opened buffers. This is easier to press.
nnoremap <C-s> <C-^>

" Set ' mark on "k" and "j" movements if they are jumping multiple lines
" to emulate populating the jumplist.
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection()<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection()<CR>?<C-R>=@/<CR><CR>

" Moving visually selected text around with proper indentation
vnoremap <Up> :m '<-2<CR>gv=gv
vnoremap <Down> :m '>+1<CR>gv=gv

" Toggle spell checking
map <leader>ss :setlocal spell!<cr>
" Respectively go to next misspelled word, previous, add to dictionary, fix
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>sf z=

" Toggle paste mode on and off -- mnemomic: <c-v> to paste so <leader>v
map <leader>v :setlocal paste!<cr>

" Copy file content to clipboard
if has("mac") || has("macunix")
    nmap <silent> <leader>cf :! pbcopy < %<CR>
elseif has("unix")
    nmap <silent> <leader>cf :! cat % \| xclip -selection c<CR>
endif

" Use Esc in terminal to enter normal mode. This does interfere
" with the vi-mode from zsh, but this does not matter as it has
" the exact same functionality.
tnoremap <Esc> <C-\><C-n>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO: Improve by not using global command but just finding
" whether there exists a quickfix window. This way the toggle
" will always be instant, even if another plugin opened the quickfix
" window. Since this toggle is not the only handle to open and close
" the quickfix the state of `g:qfix_win` may be incorrect.
" https://vim.fandom.com/wiki/Toggle_to_open_or_close_the_quickfix_window
function! QFixToggle()
  if exists("g:qfix_win")
    " If the buffer in the current window is the quickfix window, i.e.
    " the cursor is currently in the quickfix window, then first jump
    " to the previous window (so the window you came from) before
    " closing the quickfix window.
    if bufnr("%") == g:qfix_win
      execute "normal! \<C-w>p"
    end
    cclose
    unlet g:qfix_win
  else
    " Open quickfix window and let it occupy the full window width.
    botright copen
    let g:qfix_win = bufnr("$")
  endif
endfunction

function! VisualSelection() range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
