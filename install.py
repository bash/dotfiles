#!/usr/bin/env python3

import os
from os import symlink, path
import platform
from pathlib import Path
from glob import iglob as glob
from subprocess import check_call, check_output
import tomllib

HOME = str(Path.home())
GREEN = "\033[32m"
YELLOW = "\033[33m"
RESET = "\033[0m"


def makedirs(path):
    os.makedirs(path, exist_ok=True)


linked_files = [
    ".editorconfig",
    ".config/fish/conf.d",
    ".config/fish/config.fish",
    ".config/fish/functions",
    ".config/git/config",
    ".config/git/.gitignore",
    ".config/sqlite3/sqliterc",
    ".config/1Password/ssh/agent.toml",
    ".local/bin/flacs2mp3s",
    ".vimrc",
]

if platform.system() == "Linux":
    linked_files += [
        ".config/color-scheme-sync.d",
        ".config/Code/User/settings.json",
        ".config/sublime-merge/Packages/User/Preferences.sublime-settings",
        ".config/autostart/1password.desktop",
        ".config/environment.d",
        ".config/user-tmpfiles.d",
        ".config/wireplumber",
        ".local/bin/code",
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

with open("vscode.toml", "rb") as f:
    vscode_extensions = tomllib.load(f)["extensions"]

for file in linked_files:
    src_path = path.join(path.dirname(path.realpath(__file__)), file)
    link_path = path.join(HOME, file)
    makedirs(path.dirname(link_path))
    try:
        print(f"Symlink '{src_path}' -> '{link_path}'", end="")
        symlink(path.relpath(src_path, start=path.dirname(link_path)), link_path)
        print(f" [{GREEN}ok{RESET}]")
    except FileExistsError:
        print(f" [{YELLOW}skipped{RESET}]")

for file in touch_files:
    dest_path = path.join(HOME, file)
    if not os.path.exists(dest_path):
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

installed_vscode_extensions = (
    check_output(["code", "--list-extensions"]).decode("utf-8").splitlines()
)
for extension in set(vscode_extensions) - set(installed_vscode_extensions):
    check_call(["code", "--install-extension", extension])
