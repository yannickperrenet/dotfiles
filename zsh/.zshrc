# Looking to get something done in zsh? Have a look at:
#       man zshall
# and ofcourse:
#       http://zsh.sourceforge.net/Guide/zshguide.html

# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# Load the aliases.
source "$XDG_CONFIG_HOME/shell/aliasrc"

HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=$XDG_CACHE_HOME/zsh/history

# Can be used to color items in the completion list.
# zmodload zsh/complist

# Case insensitive TAB completion allowing you to type lowercase and
# being completed to lower and uppercase.
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

#################
# Layout
#################
# Custom theme.
fpath+=$XDG_CONFIG_HOME/zsh/themes/pure
autoload -U promptinit; promptinit
zstyle :prompt:pure:path color "#add8e6"
prompt pure

#################
# ZSH Plugins
#################
# vi-mode
# Plugin used: https://github.com/softmoth/zsh-vim-mode
# NOTE: Use `<C-x><C-e>` to edit the command in Vim.
MODE_INDICATOR=""
MODE_CURSOR_VIINS="beam"
source $XDG_CONFIG_HOME/zsh/plugins/zsh-vim-mode/zsh-vim-mode.plugin.zsh

# Set the timeout to a minimal 0.01s after hitting ESC to enter
# vi-mode.
export KEYTIMEOUT=1

# Jump around based on rank and frequency.
_Z_DATA=$XDG_CACHE_HOME/z
source /home/yannick/.config/zsh/plugins/z/z.sh

# NOTE: Has to be run all the way at the bottom of the `.zshrc` file.
# From the docs: "In zsh newer than 5.8 (not including 5.8 itself),
# zsh-syntax-highlighting uses the add-zle-hook-widget facility to
# install a zle-line-pre-redraw hook. Hooks are run in order of
# registration, therefore, z-sy-h must be sourced (and register its
# hook) after anything else that adds hooks that modify the command-line
# buffer."
source $XDG_CONFIG_HOME/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#################
# CLI Plugins
#################
# NOTE: The <C-r> mapping conflicts with the vi-mode zsh-plugin, thus
# the use of fzf has to be below it (since I rather want to use the fzf
# functionality).
# According to their README: "Refer to the package documentation for
# more information. (e.g.  apt-cache show fzf)"
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
