#!/usr/bin/env python3

import os
from os import symlink, path
import platform
from pathlib import Path
from glob import iglob as glob
from subprocess import check_call, check_output
from tempfile import NamedTemporaryFile
import tomllib

HOME = str(Path.home())
GREEN = "\033[32m"
YELLOW = "\033[33m"
RESET = "\033[0m"


def makedirs(path):
    os.makedirs(path, exist_ok=True)


def pretty_path(path: str) -> str:
    return path.replace(HOME, "~", 1) if path.startswith(HOME) else path


linked_files = [
    ".editorconfig",
    ".config/alacritty",
    ".config/nvim",
    ".config/tmux",
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
        ".config/kitty",
        ".config/color-scheme-sync.d",
        ".config/Code/User/settings.json",
        ".config/sublime-merge/Packages/User/Preferences.sublime-settings",
        ".config/autostart/1password.desktop",
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
        print(
            f"Symlink '{pretty_path(src_path)}' -> '{pretty_path(link_path)}'", end=""
        )
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
    if not path.exists(original):
        original = path.join("/var/lib/flatpak/exports", file_name)
    patch = path.join("patch-usr", f)
    patched = path.join(HOME, ".local", file_name)
    if path.exists(original):
        print(f"Patching {pretty_path(original)} -> {pretty_path(patched)}")
        # patch is not happy when trying to read from symlinks, so we copy the source file first
        with NamedTemporaryFile(suffix=".patch") as original_tmp:
            with open(original, "rb") as f:
                original_tmp.write(f.read())
                original_tmp.flush()
            makedirs(path.dirname(patched))
            check_call(["patch", original_tmp.name, patch, "--output", patched])

installed_vscode_extensions = (
    check_output(["code", "--list-extensions"]).decode("utf-8").splitlines()
)
for extension in set(vscode_extensions) - set(installed_vscode_extensions):
    check_call(["code", "--install-extension", extension])

extra_vscode_extensions = set(installed_vscode_extensions) - set(vscode_extensions)
if len(extra_vscode_extensions) >= 1:
    print(f"{YELLOW}Warning{RESET}: extra VSCode extensions found")
    print("\n".join([f"• {ext}" for ext in extra_vscode_extensions]))
