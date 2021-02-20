# Dotfiles

> Special thanks to [LukeSmithxyz/voidrice](https://github.com/LukeSmithxyz/voidrice)

## Installation
For an installation script, please refer to my
[iscripts](https://github.com/yannickperrenet/iscripts) repository.

After installing the dotfiles use the respective package managers, see the sections below.

To keep the dotfiles up to date:
```bash
# `dfg` is an alias set in this repository to manage this repository as
# a bare git repository.
dfg pull

# Update submodules and automatically initialize newly added submodules.
dfg submodule update --init
```

### iTerm2
> Used for macOS only.

Activating Dracula theme, as can be found on the official
[Dracula theme](https://draculatheme.com/iterm/) website:
1. _iTerm2 > Preferences > Profiles > Colors Tab_
2. Open the _Color Presets..._ drop-down in the bottom right corner
3. Select _Import..._ from the list
4. Select the _Dracula.itermcolors_ file (which is located at `~/.config/iterm2/dracula/`)
5. Select the _Dracula_ from the _Color Presets..._

### Vim
My special thanks goes out to the [Ultimate Vim configuration](https://github.com/amix/vimrc) which
has helped me out a great deal to get started with my own `.vimrc`.

Use [Vundle](https://github.com/VundleVim/Vundle.vim) to manage packages, run `:PluginInstall` to
install the plugins (once inside Vim).

### tmux
> You need to have at least version 3.1 installed. Otherwise tmux will not look inside the
> `~/.config` directory and you would need to symlink the `tmux.conf` in the home directory.

Basically a clone of [Oh My Tmux!](https://github.com/gpakosz/.tmux)

Use the [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) and run `prefix + I` to install
the plugins (once tmux is activated)

### i3-gaps
Set the color of the terminal:
1. *Edit* > *Preferences* > *Profiles* > *Colors*
2. Select *Solarized dark* in the drop down for *Built-in schemes* (or the *GNOME dark* theme)

Set the font of the terminal:
1. *Edit* > *Preferences* > *Profiles* > *Text*
2. *Custom font* > *Monospace 11*

Disable the menubar of the terminal:
1. *Edit* > *Preferences* > *General*
2. Untick the *Show menubar by default in new terminals*
