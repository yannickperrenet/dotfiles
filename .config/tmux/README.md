# tmux
In case I ever feel like updating the tmux configurations, I should not forget to put the following
line at the end of the `.tmux.conf` file.
```
if '[ -f ~/.config/tmux/tmux.conf.extra ]' 'source ~/.config/tmux/tmux.conf.extra'
```

## Custom mappings
Please refer to the `tmux.conf.extra` file.

## Plugins
Some useful shortcuts for TPM (Tmux Plugin Manager)
* `prefix + Alt + u` to uninstall no-longer-listed plugins
* `prefix + U` to update plugin(s)
