#!/bin/sh
if [ "$1" = period-changed ]; then
    case $3 in
        daytime)
            ln -sf "$XDG_CONFIG_HOME"/alacritty/day.toml "$XDG_CONFIG_HOME"/alacritty/alacritty.toml
            echo "day" > "$XDG_DATA_HOME"/redshift/current_period
            sed -i s/1/0/ "$XDG_CONFIG_HOME/gtk-3.0/settings.ini"
            ;;
        transition)
            if [ "$2" = none ]; then
                ln -sf "$XDG_CONFIG_HOME"/alacritty/night.toml "$XDG_CONFIG_HOME"/alacritty/alacritty.toml
                echo "night" > "$XDG_DATA_HOME"/redshift/current_period
                sed -i s/0/1/ "$XDG_CONFIG_HOME/gtk-3.0/settings.ini"
            fi
            ;;
        night)
            ln -sf "$XDG_CONFIG_HOME"/alacritty/night.toml "$XDG_CONFIG_HOME"/alacritty/alacritty.toml
            echo "night" > "$XDG_DATA_HOME"/redshift/current_period
            sed -i s/0/1/ "$XDG_CONFIG_HOME/gtk-3.0/settings.ini"
    esac
fi
