# If not running interactively, don't do anything
[[ $- == *i* ]] || return

HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=$XDG_CACHE_HOME/zsh/history

fpath+=$XDG_CONFIG_HOME/zsh/themes/pure
autoload -U promptinit; promptinit
prompt pure

# vi-mode
# https://github.com/softmoth/zsh-vim-mode
# TODO: look into https://github.com/b4b4r07/zsh-vimode-visual
MODE_INDICATOR=""
source $XDG_CONFIG_HOME/zsh/plugins/zsh-vim-mode/zsh-vim-mode.plugin.zsh

# Set the timeout to a minimal 0.01s after hitting ESC to enter
# vi-mode.
export KEYTIMEOUT=1

# Load the aliases.
source "$XDG_CONFIG_HOME/shell/aliasrc"

#################
# fzf
#################
# According to their README: "Refer to the package documentation for
# more information. (e.g.  apt-cache show fzf"
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
