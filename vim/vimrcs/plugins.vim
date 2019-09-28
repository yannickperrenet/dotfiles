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
" call vundle#begin('~/.vim_configs/plugins')
call vundle#begin('~/.config/vim/plugins')

" Let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" Additional Plugins
" Styling
Plugin 'itchyny/lightline.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/nerdtree'
Plugin 'yuttie/comfortable-motion.vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'mileszs/ack.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'maxbrunsfeld/vim-yankstack'

Plugin 'vimwiki/vimwiki'

" All of your Plugins must be added before the following line
call vundle#end()
