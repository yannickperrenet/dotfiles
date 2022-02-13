"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set window title of terminal (used for searching open windows)
set title
set titlestring=Nvim:\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)%(\ (%{getcwd()})%)

" Set number of lines to remember. Past commands are stored in the file
" ~/.viminfo
set history=500

" Enable filetype plugins, e.g. the standard included python.vim
filetype plugin on
filetype indent on

" When a file has been changed outside of Vim, automatically read it again.
" Note: it does not reload files unless you run an external command like
" !ls Manually reloading a file can be done using :e
set autoread

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the wildmenu. This enables a menu at the bottom of the window
" when typing a command, e.g. :color <TAB>
set wildmenu

" Ignore compiled files. For example when using the CtrlP plugin, it will
" ignore the .git files.
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/venv/*

" Always show current position. This way you know the row and column you
" are on.
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned. It hides buffers instead
" of closing them. This means that you can have unwritten changes to a file
" and open a new file using :e, without being forced to write or undo your
" changes first. Also, undo buffers and marks are preserved while the buffer
" is open.
set hid

" Configure backspace so it acts as it should act. You can now backspace
" over all characters (instead of only once in insert mode).
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching and try to be smart about cases. Now typing
" /example would match both example and Example.
set ignorecase
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers. Highlights incrementally.
" Thus whilst searching it will move the highlight.
set incsearch

" Neovim requires this so that 'incsearch' affects commands also.
set inccommand=split

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
set foldcolumn=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Enable 256 colors palette in Gnome Terminal
if ($COLORTERM == 'gnome-terminal' || $COLORTERM == 'truecolor')
    set t_Co=256
endif

" Colorscheme
" Cannot set the peaksea colorscheme here yet, because pathogen is sourced
" after the general.vim configurations.
try
    colorscheme desert
catch
endtry

" Set font according to system
if has("mac") || has("macunix")
    set gfn=IBM\ Plex\ Mono:h14,Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
elseif has("win16") || has("win32")
    set gfn=IBM\ Plex\ Mono:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
    set gfn=IBM\ Plex\ Mono:h14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("linux")
    set gfn=IBM\ Plex\ Mono:h14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("unix")
    set gfn=Monospace\ 11
endif

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t

    " Disable scrollbars (real hackers don't use scrollbars for navigation!)
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
endif


" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
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
