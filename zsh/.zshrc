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
