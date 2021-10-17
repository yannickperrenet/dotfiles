#!/bin/sh

# Execute commands before the window manager is started.
. "$XDG_CONFIG_HOME/x11/xprofile"

# Start window manager.
exec i3
