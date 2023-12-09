#!/usr/bin/env bash
set -e

tmp_dir=$(mktemp -d)

wget2 -O "$tmp_dir/mdcat.tar.gz" 'https://github.com/swsnr/mdcat/releases/download/mdcat-2.1.0/mdcat-2.1.0-x86_64-unknown-linux-musl.tar.gz'
echo "a35d662e07ba33c6503b5d1c2725d1b3e233825a9f98f4faf9a8973cc6d158b5 $tmp_dir/mdcat.tar.gz" | sha256sum --check
mkdir -p ~/.local/bin
tar -xvf "$tmp_dir/mdcat.tar.gz" 'mdcat-*/mdcat' -O > ~/.local/bin/mdcat
chmod +x ~/.local/bin/mdcat
mkdir -p ~/.local/share/man/man1/
tar -xvf "$tmp_dir/mdcat.tar.gz" 'mdcat-*/mdcat.1' -O > ~/.local/share/man/man1/mdcat.1

rm -rf "$tmp_dir"