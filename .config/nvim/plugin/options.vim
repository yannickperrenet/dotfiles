" Set window title of terminal (used for searching open windows)
set title
" Nvim: options.vim (plugin) (/home/user/.config/nvim)
set titlestring=Nvim:\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)%(\ (%{getcwd()})%)

" Enable loading filetype detection, filetype plugins and filetype indent
" NOTE: Must come after `packadd` calls, because `packadd` adds
" to `runtimepath` and we want to make sure that `ftdetect`
" directories of packages are evaluated.
filetype plugin indent on

" :W --> sudo saves the file. Useful for permission-denied errors.
command W w !sudo tee % > /dev/null

" TODO: Structure all autocommands together
" Return to last edit position when opening files (You want this!)
" When starting to edit an existing file (any filetype), do:
" - line("'\"") gets the line number of the cursor position when last
"   exiting the current buffer.
"   - 'x get position of mark x
"   - \" means the mark " which is the cursor position when last exiting
"     the current buffer
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

set relativenumber  " great for fast multi-line movement
set number  " still show actual current line number

set textwidth=100  " Linebreak on 100 characters
set whichwrap=b,h,l,s,<,>,[,],~

" Great for Python or structuring note taking
if has('folding')
    set foldmethod=indent
    set foldnestmax=3
    " If zero, all folds are closed.
    set foldlevelstart=3
endif

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=10

" Command-line completion using `<Tab>` (the default `wildchar`)
set wildmenu
" Patterns to ignore in the `wildmenu`
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/venv/*

" A buffer becomes hidden when it is abandoned. It hides buffers instead
" of closing them. This means that you can have unwritten changes to a file
" and open a new file using :e, without being forced to write or undo your
" changes first. Also, undo buffers and marks are preserved while the buffer
" is open.
set hidden

" Unrestricted backspacing in insert mode.
set backspace=eol,start,indent

set ignorecase  " Ignore case when searching ...
set smartcase  " ... unless there is a capital in the query

set hlsearch  " Highlight search results
set incsearch  " Highlight incrementally whilst typing the search
set inccommand=split  " Live preview of :s results

set lazyredraw  " Don't redraw while executing macros
set belloff=all  " No annoying sound on errors
set timeoutlen=500  " ms to wait for a mapped sequence to complete

" Show matching brackets when text indicator is over them
set showmatch

" Add a bit extra margin to the left
set foldcolumn=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Colorscheme
" Cannot set the peaksea colorscheme here yet, because pathogen is sourced
" after the general.vim configurations.
try
    colorscheme desert
catch
endtry


" Don't create backups when writing.
set nobackup
set nowritebackup
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces. 'Each shiftwidth worth of indent adds on to the
" depth of the fold. This is called a fold level.'
set shiftwidth=4
set tabstop=4

" Prevent line wrapping to split words over two lines.
set linebreak

" Linebreak on 500 characters
set tw=100

set ai "Auto indent
set si "Smart indent

" Wrap lines visually, i.e. the line is still one line of text, but Vim
" displays it on multiple lines. This way you do not have to scroll
" horizontally.
set wrap

" Specify the behavior when switching between buffers
try
  " This was included in amix/vimrc but I have not yet understood
  " why you would ever want to have usetab and newtab enabled
  " set switchbuf=useopen,usetab,newtab

  " This way all buffer opening works as expected with shortcuts
  set switchbuf=useopen
  set stal=2
catch
endtry


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Set paths to cache
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Used to be `viminfo`
set shadafile=$XDG_DATA_HOME/nvim/shada/main.shada
" See 'undo-persistence'
set undofile
let g:netrw_home='$XDG_DATA_HOME/nvim'

" Enable mouse
set mouse=a

" Show [text link](link to something) as text link
"set conceallevel=2

" Preview window settings.
set completeopt=menu,menuone,noinsert,noselect
set previewheight=10
set splitbelow

" set signcolumn=yes
set numberwidth=1

" Otherwise the linting might trigger and 'de-trigger' the
" signcolumn 24/7, making the screen go from left to right
" to left to right to left....
set signcolumn=yes

""""""""""""""""""""""""""""""
" => Colorscheme and Fonts
""""""""""""""""""""""""""""""
let curr_period = readfile($XDG_DATA_HOME.'/redshift/current_period')[0]
if curr_period == 'day'
    " This value is remapped in the alacritty.yml
    let g:seoul256_background = 255
else
    let g:seoul256_background = 240
endif
colorscheme seoul256
" hi Normal cterm=NONE ctermbg=255

" When guicolors are enabled, the color remapping does not work.
" if has('termguicolors')
"   set termguicolors
" endif

" Peaksea set up:
" set background=dark
" colorscheme peaksea

" Color the cursorline
" hi CursorLine cterm=NONE ctermbg=53
"
" OMG, without this the signcolumn is displayed as DarkGreen
" ... so ugly
" highlight SignColumn ctermfg=none ctermbg=none
"
" Alternative:
" colorscheme ron
