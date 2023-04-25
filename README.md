# Dotfiles

> Inspiration taken from [LukeSmithxyz/voidrice](https://github.com/LukeSmithxyz/voidrice).

## Installation
For an installation script, please refer to my
[iscripts](https://github.com/yannickperrenet/iscripts) repository.

To keep the dotfiles up to date:
```bash
# `dfg` is an alias set in this repository to manage this repository as
# a bare git repository.
dfg pull

# Update submodules and automatically initialize newly added submodules.
dfg submodule update --init
```

## Adding submodules

```sh
# For example:
dfg submodule add -- https://github.com/nvim-telescope/telescope-fzf-native.nvim .config/nvim/pack/bundle/opt/telescope-fzf-native.nvim
```
