# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# Load the shell dotfiles
for file in ~/.config/{bash_prompt,aliasrc}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Set ENV for Finder-launched applications
# launchctl setenv PATH $PATH

# We don't want zsh to be interferring with Vim mappings.
# stty -ixon
# stty -tostop
