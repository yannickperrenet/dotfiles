""""""""""""""""""""""""""""""
" => Load pathogen paths
""""""""""""""""""""""""""""""
" Use pathogen to manage vim runtimepath to install plugins and runtime
" files in their own private directories.

" Set the path to the vim_configs directory relatively from the current
" directory. The '<sfile>:p:h' gets the folder in which this script is
" located.
let s:vim_configs = expand('<sfile>:p:h')."/.."

" Make the expansion occur in the plugins directory.
call pathogen#infect(s:vim_configs.'/plugins/{}')
call pathogen#infect(s:vim_configs.'/plugins_forked/{}')

" Generate documentation of the plugins by invoking the :Helptags command.
call pathogen#helptags()


""""""""""""""""""""""""""""""
" => vim-plug
""""""""""""""""""""""""""""""
let s:plugins_path=$XDG_CONFIG_HOME.'/nvim/plugins'
call plug#begin(fnameescape(s:plugins_path))

" Additional Plugins
" Styling and filetypes
Plug 'itchyny/lightline.vim'
Plug 'godlygeek/tabular'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'rust-lang/rust.vim'

" Searching
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'

" Jumping around
Plug 'easymotion/vim-easymotion'

" Other
Plug 'yuttie/comfortable-motion.vim'
Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-fugitive'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vimwiki/vimwiki'
Plug 'maxbrunsfeld/vim-yankstack'

" All of your Plugins must be added before the following line
call plug#end()
