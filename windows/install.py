# /// script
# dependencies = [
#     "termcolor~=2.4.0",
# ]
# ///

import os
from os import symlink, path, unlink
from pathlib import Path
from subprocess import check_call
from typing import Optional
from termcolor import colored


def install():
    update_submodules()

    with open(path.join(path.dirname(__file__), "symlinks.txt")) as f:
        symlinks = [parse_symlink(line) for line in f.readlines()]
    symlink_files(symlinks)

    with open(path.join(path.dirname(__file__), "symlinks.txt")) as f:
        env_vars = [parse_env_var(line) for line in f.readlines() if line is not None]
    set_env_vars(env_vars)


def update_submodules():
    check_call(["git", "submodule", "update", "--init", "--recursive"])


def parse_symlink(input: str) -> tuple[str, str]:
    input = input.strip()
    if "->" in input:
        link, dest = (path.strip() for path in input.split("->", maxsplit=2))
        return (link, dest)
    else:
        return (input, input)


def parse_env_var(input: str) -> Optional[tuple[str, str]]:
    input = input.strip()
    if len(input) == 0 or input.startswith("#"):
        return None
    parts = input.split("=", maxsplit=1)
    if len(parts) != 2:
        raise Exception(f"Invalid environment variable '{input}'")
    return (parts[0], parts[1])


def symlink_files(files: list[tuple[str, str]]) -> None:
    for link_name, dest_name in files:
        src_path = path.realpath(path.join(path.dirname(path.realpath(__file__)), dest_name))
        link_path = path.join(HOME, link_name)
        if not path.exists(src_path):
            print(f"{colored('error', color='red')}: source file '{pretty_path(src_path)}' does not exist")
            exit(1)
        makedirs(path.dirname(link_path))
        try:
            print(
                f"Symlink '{pretty_path(link_path)}' -> '{pretty_path(src_path)}'",
                end="",
            )
            update = path.islink(link_path)
            if update:
                unlink(link_path)
            symlink(path.relpath(src_path, start=path.dirname(link_path)), link_path)
            if update:
                print(f" [{colored('ok, updated', color='green')}]")
            else:
                print(f" [{colored('ok, new', color='green')}]")
        except FileExistsError:
            print(f" [{colored('skipped', color='yellow')}]")


def set_env_vars(env_vars: list[tuple[str, str]]) -> None:
    for (name, value) in env_vars:
        check_call(["setx", name, value])


HOME = str(Path.home())
DOTFILES = path.realpath(path.join(path.dirname(path.realpath(__file__)), ".."))


def makedirs(path):
    os.makedirs(path, exist_ok=True)


def pretty_path(path: str) -> str:
    if path.startswith(DOTFILES):
        return path.replace(DOTFILES, "{dotfiles}", 1)
    elif path.startswith(HOME):
        return path.replace(HOME, "~", 1)
    else:
        return path


if __name__ == "__main__":
    install()
