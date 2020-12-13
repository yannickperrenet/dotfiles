# If not running interactively, don't do anything
[[ $- == *i* ]] || return

fpath+=$XDG_CONFIG_HOME/zsh/themes/pure
autoload -U promptinit; promptinit
prompt pure

# vi-mode
# https://github.com/softmoth/zsh-vim-mode
# TODO: look into https://github.com/b4b4r07/zsh-vimode-visual
MODE_INDICATOR=""
source ~/.config/zsh/plugins/zsh-vim-mode/zsh-vim-mode.plugin.zsh

# Set the timeout to a minimal 0.01s after hitting ESC to enter
# vi-mode.
export KEYTIMEOUT=1

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
# if [[ ! "$PATH" == *$HOME/.config/fzf/bin* ]]; then
#   export PATH="${PATH:+${PATH}:}$HOME/.config/fzf/bin"
# fi
# 
# # Auto-completion
# # ---------------
# [[ $- == *i* ]] && source "$HOME/.config/fzf/shell/completion.zsh" 2> /dev/null
# 
# # Key bindings
# # ------------
# source "$HOME/.config/fzf/shell/key-bindings.zsh"
