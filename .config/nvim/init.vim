"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: Yannick Perrenet
" https://github.com/yannickperrenet
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Structure of my Neovim configuration.
"
" ./after/plugin/*.vim AND ./after/plugin/*.lua
"   Third-party plugin configurations (see `./pack/bundle/opt/*`).
"
"   - Automatically picked up through `runtimepath`.
"   - `*.vim` files are always sourced before `*.lua` files.
"
" ./after/ftplugin/*.vim
"   Filetype plugin configurations.
"
"   - Automatically picked up through `runtimepath`.
"
" ./pack/bundle/opt/*
"   Directory that holds my (third-party) plugins.
"
"   - I manage the plugins through `git submodule`.
"   - Add plugins to `runtimepath` by searching `packpath` for
"     `./pack/*/opt/{name}` using `packadd {name}` in a runtime
"     file, i.e. run `packadd {name}` to add a plugin.
"
" ./init.vim
"   Initialization file.
"
"   - Run as the very first file in the entire initialization process
"     and thus great to initialize things that need to be defined early.
"
" ./plugin/*.vim AND ./plugin/*.lua
"   My own plugins.
"
"   - Includes my options (e.g. `set incsearch`) and keymaps.
"
" ./lua/yannick/*.lua AND ./lua/yannick/?/*.lua
"   Lua modules.
"
"   - Placed in the `yannick` namespace to prevent collisions of file
"     names with other files from plugins in their `./lua` directory.
"   - These files are all included in the Lua module system. Therefore,
"     all the modules defined here can be called from any other `*.lua`
"     file (in the entire Neovim configuration) using:
"
"       require('yannick.<name>')
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Some useful commands when working on the configuration:
" - `:checkhealth` -- debug information.
" - `:scriptnames` -- evaluation order of all scripts.
" - `nvim --startuptime nvim.log` -- get profiling info.
" - `:set runtimepath`

" From tjdevries:
" > In general, it's a good idea to set this early in your config,
" > because otherwise if you have any mappings you set BEFORE doing
" > this, they will be set to the OLD leader.
let mapleader = " "

" Disable some builtin plugins that I don't use.
let g:loaded_gzip = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_2html_plugin = 1

" No default key mappings to prevent it overwriting other mappings.
let g:comfortable_motion_no_default_key_mappings = 1
let g:EasyMotion_do_mapping = 0

" Third-party plugins
" If the help doc tags can't be found, e.g. `:h ctrlp` then you need to
" run the command `:helptags ALL`
" packadd! LuaSnip
" packadd! cmp_luasnip
packadd! lightline.vim
packadd! rust.vim
packadd! vim-commentary
packadd! vim-easymotion
packadd! vim-indent-object

" Telescope fuzzy finder
packadd! plenary.nvim  " Dependency of telescope
packadd! telescope.nvim
packadd! telescope-fzf-native.nvim

" TODO: nvim-treesitter
packadd! nvim-treesitter
packadd! nvim-treesitter-textobjects
packadd! playground

" Easy text alignment (e.g. for tables in markdown)
packadd! tabular
" Distraction-free writing
packadd! goyo.vim
" Smooth scrolling with `<C-d>` and `<C-u>`
packadd! comfortable-motion.vim
" Colorschemes
packadd! peaksea
packadd! seoul256.vim

" --- LSP config
" Collection of (quickstart) LSP configs. This way you can easily add new
" language servers. It is a convenience layer, NOT a requirement.
" `:h lspconfig`
packadd! nvim-lspconfig
" Add `nvim-cmp` capabilities to the built-in Nvim LSP client
" capabilities. This way the language server provides better completion
" results as the client (which is Nvim) has more capabilities.
" Basically, on each request to the language server it now adds
" additional capabilities.
packadd! cmp-nvim-lsp
" Autocompletion, see `:help nvim-cmp`
" Nvim does not support built-in autocompletion so a plugin is needed.
packadd! nvim-cmp
" Display function signature while entering parameters
packadd! cmp-nvim-lsp-signature-help
