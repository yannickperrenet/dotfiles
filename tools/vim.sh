#!/usr/bin/env bash
set -e

cp -rf ~/.config/vim/plugins_forked/vimwiki-styling ~/Google\ Drive/vimwiki/

echo 'set runtimepath+=~/.config/vim

source ~/.config/vim/vimrcs/general.vim
source ~/.config/vim/vimrcs/filetypes.vim
source ~/.config/vim/vimrcs/plugins.vim
source ~/.config/vim/vimrcs/plugin_configs.vim
source ~/.config/vim/vimrcs/test_configs.vim' > ~/.vimrc
