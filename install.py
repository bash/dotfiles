#!/usr/bin/env python3

import os
from os import symlink, path
import platform
from pathlib import Path

HOME = str(Path.home())


def makedirs(path):
    print(f"Creating directory '{path}'")
    os.makedirs(path, exist_ok=True)


linked_files = [
    ".editorconfig",
    ".gitconfig",
    ".gitignore",
    ".sqliterc",
    ".zshrc",
    ".zshrc.d",
]

if platform.system() == "Linux":
    linked_files += [
        ".config/autostart/1password.desktop",
        ".config/wireplumber",
    ]

touch_files = [
    ".gitconfig.d/local.gitconfig",
    ".gitconfig.d/github.gitconfig",
]

for file in linked_files:
    src_path = path.join(path.dirname(path.realpath(__file__)), file)
    dest_path = path.join(HOME, file)
    print(f"Creating symlink '{src_path}' -> '{dest_path}'")
    try:
        symlink(src_path, dest_path)
    except FileExistsError:
        print(f"WARN: Symlink destination '{dest_path}' already exists, skipping...")

makedirs(path.join(HOME, ".gitconfig.d"))

for file in touch_files:
    dest_path = path.join(HOME, file)
    print(f"Touching '{dest_path}'...")
    with open(dest_path, "a"):
        pass
