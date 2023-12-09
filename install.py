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
    ".zshrc",
    ".zshrc.d",
    ".config/git/config",
    ".config/git/.gitignore",
    ".config/sqlite3/sqliterc",
    ".config/Code/User/settings.json",
    ".config/1Password/ssh/agent.toml",
]

if platform.system() == "Linux":
    linked_files += [
        ".config/autostart/1password.desktop",
        ".config/wireplumber",
        ".config/user-tmpfiles.d",
    ]

touch_files = [
    ".config/git/local.gitconfig",
    ".config/git/github.gitconfig",
]

for file in linked_files:
    src_path = path.join(path.dirname(path.realpath(__file__)), file)
    link_path = path.join(HOME, file)
    makedirs(path.dirname(link_path))
    print(f"Creating symlink '{src_path}' -> '{link_path}'")
    try:
        symlink(path.relpath(src_path, start=path.dirname(link_path)), link_path)
    except FileExistsError:
        print(f"WARN: Symlink destination '{link_path}' already exists, skipping...")

for file in touch_files:
    dest_path = path.join(HOME, file)
    print(f"Touching '{dest_path}'...")
    with open(dest_path, "a"):
        pass
