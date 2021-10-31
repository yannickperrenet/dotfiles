#!/bin/sh
if [ "$1" = period-changed ]; then
    case $3 in
        daytime)
            ln -sf "$XDG_CONFIG_HOME"/alacritty/day.yml "$XDG_CONFIG_HOME"/alacritty/alacritty.yml
            echo "daytime" > "$XDG_DATA_HOME"/redshift/current_period
            ;;
        transition)
            if [ "$2" = none ]; then
                ln -sf "$XDG_CONFIG_HOME"/alacritty/night.yml "$XDG_CONFIG_HOME"/alacritty/alacritty.yml
                echo "night" > "$XDG_DATA_HOME"/redshift/current_period
            fi
            ;;
        night)
            ln -sf "$XDG_CONFIG_HOME"/alacritty/night.yml "$XDG_CONFIG_HOME"/alacritty/alacritty.yml
            echo "night" > "$XDG_DATA_HOME"/redshift/current_period
    esac
fi
