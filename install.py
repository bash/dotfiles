#!/usr/bin/env python3

import os
from os import symlink, path
import platform
from pathlib import Path
from glob import iglob as glob
from subprocess import check_call

HOME = str(Path.home())


def makedirs(path):
    print(f"Creating directory '{path}'")
    os.makedirs(path, exist_ok=True)


linked_files = [
    ".editorconfig",
    ".zshrc",
    ".zshrc.d",
    ".config/fish/conf.d",
    ".config/fish/config.fish",
    ".config/fish/functions",
    ".config/git/config",
    ".config/git/.gitignore",
    ".config/sqlite3/sqliterc",
    ".config/1Password/ssh/agent.toml",
    ".local/bin/flacs2mp3s",
]

if platform.system() == "Linux":
    linked_files += [
        ".config/Code/User/settings.json",
        ".config/sublime-merge/Packages/User/Preferences.sublime-settings",
        ".config/autostart/1password.desktop",
        ".config/environment.d",
        ".config/user-tmpfiles.d",
        ".config/wireplumber",
    ]

if platform.system() == "Darwin":
    linked_files += [
        "Library/Application Support/Code/User/settings.json",
        ".Brewfile",
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

for f in glob("**/*.patch", root_dir="patch-usr", recursive=True, include_hidden=True):
    file_name = f.removesuffix(".patch")
    original = path.join("/usr", file_name)
    patch = path.join("patch-usr", f)
    patched = path.join(HOME, ".local", file_name)
    if path.exists(original):
        makedirs(path.dirname(patched))
        check_call(["patch", original, patch, "--output", patched])
