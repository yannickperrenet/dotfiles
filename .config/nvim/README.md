# Vim Dotfiles
Here you will find an up-to-date version of my vim-dotfiles.

In case things are not running as expected inside Nvim, run `:checkhealth`.

# Included Plugins
The following plugins will automatically be setup when cloning this repo
* [Pathogen](https://github.com/tpope/vim-pathogen): Manage vim runtimepath. Install plugins and runtime files in their own private directories.
* [Vundle](https://github.com/VundleVim/Vundle.vim): Plugin manager.
* [peaksea](https://github.com/vim-scripts/peaksea): color scheme.
* [vimwiki-assets](https://github.com/zweifisch/vimwiki-assets): styling for the html generated pages by vimwiki. I made some minor tweaks and renamed it to "vimwiki-styling".

Additional plugins can be loaded by running `:PluginInstall` in Vim, calling Vundle as our plugin manager.
This will install the following plugins for you
* [lightline](https://github.com/itchyny/lightline.vim): a light and configurable statusline/tabline plugin for Vim. I use it to style my statusline and tabline as well as determine what should be displayed on them.
* [vim-commentary](https://github.com/tpope/vim-commentary): comment stuff out without effort.
* [vimwiki](https://github.com/vimwiki/vimwiki): a personal wiki for Vim. I use it for most of my note taking to make them searchable but also nicely editable and readable.
* [comfortable-motion.vim](https://github.com/yuttie/comfortable-motion.vim): brings physics-based smooth scrolling to Vim.
* [ctrlp.vim](https://github.com/kien/ctrlp.vim): full path fuzzy file, buffer, mru, tag, ... finder for Vim.
* [ack.vim](https://github.com/mileszs/ack.vim): search tool within Vim, with an enhanced results list. Similar to grep.
* [ale](https://github.com/dense-analysis/ale): check syntax in Vim asynchronously and fix files,
  with LSP support.
* [vim-yankstack](https://github.com/maxbrunsfeld/vim-yankstack): allows you to cycle through items in yank stack after doing a paste.

Plugins that I used to have
* [bufexplorer.zip](https://github.com/vim-scripts/bufexplorer.zip): quickly and easily switch between buffers.
* [nerdtree](https://github.com/scrooloose/nerdtree): a file system explorer, allowing to browse directories, quickly open files and perform basic file system operations.
* [vim-fugitive](https://github.com/tpope/vim-fugitive): possibly the best Git wrapper of all time. Uses include displaying branch name in statusline (compatibility with lightline) and all other git magic from within vim.


## Custom mappings inside the vimrcs (exluding the plugins)
General
* `<leader>w` save file
* `<leader><cr>` disable highlight
* `<leader>pp` toggle paste mode on and off
* `<leader>cf` copy file content to clipboard
* `<leader>g` generates a tag file in the currently active virtual environment
* `<C-\>` opens the definition (using ctags) in vertical split
* `<leader>c` to toggle cursorline

Window movement, tab management and buffers
* `<C-j>` to go down a window, similarly for left, up and right
* `<leader>te` to open a new tab with the current buffer's path. Great when editing files in the same directory
* `<leader>cd` switch CWD to the directory of the open buffer
* `<leader>q` quickly opens a new buffer for scribble
* `<leader>l` go to the previous buffer
* `<leader>h` go to the next buffer

Text alteration
* `<leader>ss` toggle and untoggle spell checking
* `<leader>sn` go to next misspelled word
* `<leader>sp` go to previous misspelled word
* `<leader>sa` add misspelled word to dictionary
* `<leader>sf` fix misspelled word by listing suggestions

Visual mode
* Pressing `*` or `#` searches for the current selection
* `<leader>y` yanks the selection to clipboard

Normal mode
* `<leader>j` go to any word on screen (uses easymotion)
