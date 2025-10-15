# Neovim config

In case things are not running as expected inside Nvim, run `:checkhealth`.

## Mappings

Run `<leader>fk` to search through all set keymaps in Telescope.

## Plugins

For included plugins see: [pack/bundle/opt/...](pack/bundle/opt/).

### Add

```sh
# In init.vim
packadd! flash.nvim

# I like to git clone first so I can try it out before adding the submodule
cd "$XDG_CONFIG_HOME/nvim/pack/bundle/opt"
git clone https://github.com/folke/flash.nvim.git

# Adding submodule
cd
dfg submodule add -- https://github.com/folke/flash.nvim.git .config/nvim/pack/bundle/opt/flash.nvim
```

### Remove

```sh
# Remove the line from init.vim
packadd! flash.nvim

# Remove submodule
dfg submodule deinit -- .config/nvim/pack/bundle/opt/flash.nvim
dfg rm --cached .config/nvim/pack/bundle/opt/flash.nvim

# If you want to be thorough also delete the listing in the
# file: `.gitmodules`
```
