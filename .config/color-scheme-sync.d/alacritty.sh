#!/bin/sh

state_dir="$HOME/.local/state/alacritty"
config_dir="$HOME/.config/alacritty"

if [ "$COLOR_SCHEME" = "prefer-dark" ]; then
    theme_file="$config_dir/dark.toml"
else
    theme_file="$config_dir/light.toml"
fi

mkdir -p -- "$state_dir"
ln -f -s "$theme_file" "$state_dir/theme.toml"
