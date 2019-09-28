#!/usr/bin/env bash

command -v brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo "WARNING: Make sure brew is installed"
	exit 1
fi

# Profiles
ln -s -f ~/.config/profiles/profile ~/.profile
ln -s -f ~/.config/profiles/zprofile ~/.zprofile
echo "Installed [profiles]"

# oh-my-zsh. Still requires to set any plugins in the .zshrc
export ZSH_THEME="refined"
export ZSH_CUSTOM="$HOME/.config/oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
echo "Installed [oh-my-zsh]"

# tmux
ln -s -f ~/.config/tmux/tmux.conf ~/.tmux.conf
ln -s -f ~/.config/tmux/tmux.conf.local ~/.tmux.conf.local
echo "Installed [tmux]"

# Run the vim script
bash vim.sh
echo "Installed [vim]"

# Run the Homebrew script
bash homebrew.sh
echo "Installed [brew]"

