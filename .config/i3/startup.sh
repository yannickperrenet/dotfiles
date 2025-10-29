#!/bin/sh

# Generated using: i3-save-tree. See:
# https://i3wm.org/docs/layout-saving.html
# Use `xprop` to fill in the layout files.
# i3-msg "workspace --no-auto-back-and-forth 10"
# i3-msg "append_layout $XDG_CONFIG_HOME/i3/startup-layout-10.json"
i3-msg "workspace --no-auto-back-and-forth 9"
i3-msg "append_layout $XDG_CONFIG_HOME/i3/startup-layout-9.json"

# Startup apps (are included in the layout files)
(mullvad-browser &)
(brave-browser &)
# (briar-desktop &)
