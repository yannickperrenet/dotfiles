# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# Use Oh-my-zsh
source ~/.config/oh-my-zsh/zshrc

# -- User specific overwrites over oh-my-zsh
# vi-mode
bindkey -v

# Set the timeout to a minimal 0.01s after hitting ESC to enter
# vi-mode.
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

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
