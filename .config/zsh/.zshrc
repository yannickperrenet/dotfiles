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
# Share history across terminals
# setopt sharehistory
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.

# Can be used to color items in the completion list.
# zmodload zsh/complist

# Case insensitive TAB completion allowing you to type lowercase and
# being completed to lower and uppercase.
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Make cd push the old directory onto the directory stack.
setopt AUTO_PUSHD

#################
# Layout
#################
# Custom theme.
fpath+=$XDG_CONFIG_HOME/zsh/themes/pure
autoload -U promptinit; promptinit
zstyle :prompt:pure:path color "#add8e6"
prompt pure
# Overwrite how the title function is called. Important to do this after
# `prompt pure`.
prompt_pure_preexec() {
	if [[ -n $prompt_pure_git_fetch_pattern ]]; then
		# Detect when Git is performing pull/fetch, including Git aliases.
		local -H MATCH MBEGIN MEND match mbegin mend
		if [[ $2 =~ (git|hub)\ (.*\ )?($prompt_pure_git_fetch_pattern)(\ .*)?$ ]]; then
			# We must flush the async jobs to cancel our git fetch in order
			# to avoid conflicts with the user issued pull / fetch.
			async_flush_jobs 'prompt_pure'
		fi
	fi

	typeset -g prompt_pure_cmd_timestamp=$EPOCHSECONDS

	# Shows the current directory and executed command in the title while a process is active.
    DISPLAY_PATH=$(print -P "%~")  # THIS LINE IS CHANGED
	prompt_pure_set_title 'ignore-escape' "$DISPLAY_PATH: $2"  # THIS LINE IS CHANGED

	# Disallow Python virtualenv from updating the prompt. Set it to 12 if
	# untouched by the user to indicate that Pure modified it. Here we use
	# the magic number 12, same as in `psvar`.
	export VIRTUAL_ENV_DISABLE_PROMPT=${VIRTUAL_ENV_DISABLE_PROMPT:-12}
}


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
bindkey '^F' fzf-file-widget
bindkey '^X^J' fzf-cd-widget  # j for jump
