#!/usr/bin/env bash

# Check whether brew is installed.
command -v brew
if [[ $? != 0 ]] ; then
    echo "WARNING: Make sure brew is installed"
	exit 1
fi


# Profiles
ln -s -f ~/.config/profiles/profile ~/.profile
ln -s -f ~/.config/profiles/zprofile ~/.zprofile
echo "Installed [profiles]"


# oh-my-zsh.
export ZSH_THEME="refined"
export ZSH_CUSTOM="$HOME/.config/oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
npm install --global pure-prompt    # Pure theme
echo "Installed [oh-my-zsh]"


# tmux
ln -s -f ~/.config/tmux/tmux.conf ~/.tmux.conf
ln -s -f ~/.config/tmux/tmux.conf.local ~/.tmux.conf.local
echo "Installed [tmux]"


# Run the Homebrew script
bash ~/.config/tools/homebrew.sh
echo "Installed [brew]"


# Run the vim script
bash ~/.config/tools/vim.sh
echo "Installed [vim]"
