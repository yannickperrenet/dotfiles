# Dotfiles

> Special thanks to [LukeSmithxyz/voidrice](https://github.com/LukeSmithxyz/voidrice)

Currently working to make the dotfiles portably between macOS and GNU/Linux, where the dotfiles
work on both systems just not to its full entirety.

## Installation 
For installation, please refer to my [iscripts](https://github.com/yannickperrenet/iscripts)
repository.

After installation some manual work has to be conducted as can be found in the designated sections
below. It mostly comes down to using the respective package managers to install further packages.

To keep the dotfiles up to date simply run:
```bash
cd ~/.config
git pull --rebase
git submodule update --init
```

### MacOS
Make sure you have [Homebrew](https://brew.sh/) installed, if not, run
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

> The script below is deprecated but can be useful to look at:
```bash
curl -LO https://raw.githubusercontent.com/yannickperrenet/dotfiles/master/tools/install_macos.sh
sh install_macos.sh
rm install_macos.sh
```

### iTerm2
Activating Dracula theme, as can be found on the official [Dracula theme](https://draculatheme.com/iterm/) website
1. _iTerm2 > Preferences > Profiles > Colors Tab_
2. Open the _Color Presets..._ drop-down in the bottom right corner
3. Select _Import..._ from the list
4. Select the _Dracula.itermcolors_ file (which is located at `~/.config/iterm2/dracula/`)
5. Select the _Dracula_ from the _Color Presets..._

### Vim
 My special thanks go out to the [Ultimate Vim configuration](https://github.com/amix/vimrc) by amix, on which I based 80% of my configurations.

Use [Vundle](https://github.com/VundleVim/Vundle.vim) to manage packages, run `:PluginInstall` to install the plugins (once inside Vim).

### tmux
Basically a clone of [Oh My Tmux!](https://github.com/gpakosz/.tmux)

Use the [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) and run `prefix + I` to install the plugins (once tmux is activated)

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
