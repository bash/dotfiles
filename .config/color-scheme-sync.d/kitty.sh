#!/bin/sh

state_dir="$HOME/.local/state/kitty"
config_dir="$HOME/.config/kitty"

if [ "$COLOR_SCHEME" = "prefer-dark" ]; then
    theme_file="$config_dir/catppuccin/themes/mocha.conf"
else
    theme_file="$config_dir/catppuccin/themes/latte.conf"
fi

mkdir -p -- "$state_dir"
ln -f -s "$theme_file" "$state_dir/theme.conf"
killall --signal SIGUSR1 --quiet kitty || true
