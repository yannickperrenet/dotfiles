""""""""""""""""""""""""""""""
" => Visuals
""""""""""""""""""""""""""""""
" Set window title of terminal (used for searching open windows with rofi)
set title
" Title of the window when this file is open:
" Nvim: options.vim (plugin) (/home/user/.config/nvim)
set titlestring=Nvim:\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)%(\ (%{getcwd()})%)

set showtabline=2 " Always show tabline
set laststatus=2  " Always show the status line
set numberwidth=1 " Use minimal columns to show line numbers
" set foldcolumn=1  " Only show top-level folds in a dedicated column on the left

" Otherwise the linting might trigger and 'de-trigger' the
" signcolumn 24/7, making the screen go from left to right
" to left to right to left....
set signcolumn=number

" Color entire viewport, not just the rows with text
hi! link NonText LineNr

" Set colorscheme based on the time of day.
let curr_period = readfile($XDG_DATA_HOME.'/redshift/current_period')[0]
if curr_period == 'day'
    " I've changed the value for `254` in `s:rgb_map` in
    " `.config/nvim/pack/bundle/opt/seoul256.vim/colors` to be
    " equal to the value for the background of my terminal. Which
    " is defined in `alacritty.toml` to be `#eeedd1`
    let g:seoul256_srgb = 1
    let g:seoul256_background = 254
    colorscheme seoul256-light
else
    colorscheme seoul256-light
    set background=dark

    " set background=dark
    " colorscheme peaksea
    " hi CursorLine cterm=NONE ctermbg=53  " Color the cursorline
    " " OMG, without this the signcolumn is displayed as DarkGreen
    " " ... so ugly
    " highlight SignColumn ctermfg=none ctermbg=none
endif


""""""""""""""""""""""""""""""
" => Editing
""""""""""""""""""""""""""""""
set mouse=a        " Enable mouse
set relativenumber " great for fast multi-line movement
set number         " still show actual current line number
set scrolloff=10   " Minimal number of screen lines to keep above and below the cursor

" Enable loading filetype detection, filetype plugins and filetype indent
" NOTE: Must come after `packadd` calls, because `packadd` adds
" to `runtimepath` and we want to make sure that `ftdetect`
" directories of packages are evaluated.
filetype plugin indent on

" NOTE: We let treesitter do the syntax highlighting
" syntax enable  " Enable syntax highlighting
set showmatch  " Show matching brackets when text indicator is over them

set backspace=eol,start,indent  " Unrestricted backspacing in insert mode.
set expandtab     " Use spaces instead of tabs
set shiftwidth=4  " 1 tab == 4 spaces when shifting using > and <
set tabstop=4     " 1 tab == 4 spaces
set wrap          " Wrap long lines that don't fit on the screen
set whichwrap=b,h,l,s,<,>,[,],~
set breakindent   " Visually keep indentation level of wrapped lines
set showbreak=↳   " Indicate a line is wrapped by adding this char in front
set linebreak     " Hard break at characters in 'breakat'
set textwidth=100 " Hard break long lines

set splitbelow  " :split adds window below and follows it
set splitright  " :vsplit adds window to the right and follows it

" TODO: I might want `noinsert` here as well
set completeopt=menu,menuone,noselect,noinsert  " Preview window settings for insert mode completion
set pumheight=10  " Maximum number of items in completion pop-up menu

set foldmethod=indent
set foldnestmax=3
set foldlevelstart=3 " If zero, all folds are closed.

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

" Open buffer in current window, don't jump to windows that already have
" the buffer open
set switchbuf=useopen

""""""""""""""""""""""""""""""
" => Searching
""""""""""""""""""""""""""""""
set ignorecase       " Ignore case when searching ...
set smartcase        " ... unless there is a capital in the query
set hlsearch         " Highlight search results
set incsearch        " Highlight incrementally whilst typing the search
set inccommand=split " Live preview of :s results

""""""""""""""""""""""""""""""
" => Miscellaneous
""""""""""""""""""""""""""""""
set lazyredraw     " Don't redraw while executing macros
set belloff=all    " No annoying sound on errors
set timeoutlen=500 " ms to wait for a mapped sequence to complete

set viewoptions=folds  " Only store folds on :mkview
set nobackup
set nowritebackup  " Don't create backups when writing.
set noswapfile
set shadafile=$XDG_DATA_HOME/nvim/shada/main.shada
set undofile       " See 'undo-persistence'
let g:netrw_home='$XDG_DATA_HOME/nvim'
" Press `gx` to open the file under the cursor. This actually works by
" using netrw (which is installed by default).
let g:netrw_browsex_viewer="xdg-open"
