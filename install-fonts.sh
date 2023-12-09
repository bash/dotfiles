#!/usr/bin/env bash
set -e

mkdir -p ~/.local/share/fonts
wget2 https://github.com/bash/sieben-7/releases/download/1.0.0/Sieben-7-Regular.ttf -O ~/.local/share/fonts/

# Clears the font cache
fc-cache -f
