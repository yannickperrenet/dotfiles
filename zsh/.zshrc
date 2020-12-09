# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# Use Oh-my-zsh
source ~/.config/oh-my-zsh/.zshrc

# -- User specific overwrites over oh-my-zsh

# Set ENV for Finder-launched applications
# launchctl setenv PATH $PATH

# We don't want zsh to be interferring with Vim mappings.
# stty -ixon
# stty -tostop

# Load the shell dotfiles
for file in "$XDG_CONFIG_HOME"/{aliasrc,}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

#################
# fzf
#################
# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/.config/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/.config/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.config/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.config/fzf/shell/key-bindings.zsh"
