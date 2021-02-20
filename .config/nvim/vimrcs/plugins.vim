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
" => Vundle
""""""""""""""""""""""""""""""
" Pass a path where Vundle should install plugins
let s:plugins_path=$XDG_CONFIG_HOME.'/nvim/plugins'
call vundle#begin(fnameescape(s:plugins_path))

" Let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" Additional Plugins
" Styling and filetypes
Plugin 'itchyny/lightline.vim'
Plugin 'godlygeek/tabular'
Plugin 'neovim/nvim-lspconfig'
Plugin 'nvim-lua/completion-nvim'
Plugin 'rust-lang/rust.vim'

" Searching
Plugin 'mileszs/ack.vim'
Plugin 'ctrlpvim/ctrlp.vim'

" Jumping around
Plugin 'easymotion/vim-easymotion'

" Other
Plugin 'yuttie/comfortable-motion.vim'
Plugin 'tpope/vim-commentary'
" Plugin 'tpope/vim-fugitive'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'vimwiki/vimwiki'
Plugin 'maxbrunsfeld/vim-yankstack'

" All of your Plugins must be added before the following line
call vundle#end()
