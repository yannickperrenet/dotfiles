# Dotfiles

        Some things might only work on macOS.

This repository was created with the intend of giving an overview of my dotfiles as well as installing applications and such on a new machine.

I was inspired by [CoreyMSchafer/dotfiles](https://github.com/CoreyMSchafer/dotfiles) and [LukeSmithxyz/voidrice](https://github.com/LukeSmithxyz/voidrice).

## Installation 
Installation is as simple as cloning this repository and then, if applicable, use the individual package managers of the applications to install further packages.
More information can be found in the designated sections.

To keep everything up to date it is as simple as
```bash
cd ~/.config
git pull --rebase
git submodule update --init
```

### MacOS
Make sure you have [Homebrew](https://brew.sh/) installed, if not, run
```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

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

### oh-my-zsh
[Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh)

The theme should be set up automatically. Note that the `ZSH_THEME` variable is set to `"refined"`, however the theme is actually called [Pure](https://github.com/sindresorhus/pure). 
This is due to naming conflicts in OMZ and therefore to activate Pure the theme has to be set to `"refined"`.

Lastly, the `ZSH_CUSTOM` variable is also set automatically to point to the custom configurations. Although it is
alsways good to know what the value should be in case things do not work as expected:
```zsh
ZSH_CUSTOM=$HOME/.config/oh-my-zsh
```

### tmux
Basically a clone of [Oh My Tmux!](https://github.com/gpakosz/.tmux)

Use the [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) and run `prefix + I` to install the plugins (once tmux is activated)
