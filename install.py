#!/usr/bin/env python3
# /// script
# dependencies = [
#     "termcolor~=2.4.0",
#     "kdl-py~=1.2.0",
# ]
# ///

import os
from os import symlink, path, environ, unlink
import platform
from pathlib import Path
from glob import iglob as glob
from subprocess import check_call, check_output
from tempfile import NamedTemporaryFile
from termcolor import colored
import kdl
from typing import List, Optional


def install():
    update_submodules()

    with open(path.join(path.dirname(__file__), "config.kdl")) as f:
        config = kdl.parse(f.read())

    for node in config.nodes:
        match node.name:
            case "symlink":
                symlink_files(file_list_from_node(node))
            case "touch":
                touch_files(file_list_from_node(node))
            case "vscode-extensions":
                install_vscode_extensions([n.name for n in node.nodes])
            case "gnome-shell-extensions":
                if is_gnome():
                    install_gnome_shell_extensions([n.name for n in node.nodes])
            case "pipx":
                install_pipx_packages([n.name for n in node.nodes])
            case _:
                print(colored(f"Unknown node type: {node.name}", color="red"))
                exit(1)

    patch_xdg_data_dir()


def update_submodules():
    check_call(["git", "submodule", "update", "--init", "--recursive"])


def symlink_files(files: list[str]) -> None:
    for file in files:
        src_path = path.join(path.dirname(path.realpath(__file__)), file)
        link_path = path.join(HOME, file)
        makedirs(path.dirname(link_path))
        try:
            print(
                f"Symlink '{pretty_path(src_path)}' -> '{pretty_path(link_path)}'",
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


def touch_files(files: list[str]) -> None:
    for file in files:
        dest_path = path.join(HOME, file)
        if not os.path.exists(dest_path):
            print(f"Touching '{dest_path}'...")
            with open(dest_path, "a"):
                pass


def patch_xdg_data_dir() -> None:
    patch_dir = "patch-xdg-data-dir"
    patch_files = glob(
        "**/*.patch", root_dir=patch_dir, recursive=True, include_hidden=True
    )
    should_update_desktop_database = False
    for f in patch_files:
        file_name = f.removesuffix(".patch")
        original = find_original_xdg_data_file(file_name)
        patch = path.join(patch_dir, f)
        patched = path.join(xdg_data_home(), file_name)
        if original is not None:
            should_update_desktop_database = True
            print(f"Patching {pretty_path(original)} -> {pretty_path(patched)}")
            # patch is not happy when trying to read from symlinks, so we copy the source file first
            with NamedTemporaryFile(suffix=".patch") as original_tmp:
                with open(original, "rb") as f:
                    original_tmp.write(f.read())
                    original_tmp.flush()
                makedirs(path.dirname(patched))
                check_call(
                    [
                        "patch",
                        original_tmp.name,
                        patch,
                        "--output",
                        patched,
                        "--read-only=fail",
                        "--reject-file=/dev/null",
                        "--quiet",
                    ]
                )
    if should_update_desktop_database:
        check_call(['update-desktop-database', path.join(xdg_data_home(), "applications")])


def find_original_xdg_data_file(relative_path: str) -> Optional[str]:
    match = next(
        (dir for dir in xdg_data_dirs() if path.exists(path.join(dir, relative_path))),
        None,
    )
    if match is not None:
        return path.join(match, relative_path)


def xdg_data_dirs() -> List[str]:
    data_dirs = os.environ.get("XDG_DATA_DIRS", default="/usr/local/share:/usr/share")
    return [data_dir for data_dir in data_dirs.split(":")]


def xdg_data_home() -> str:
    return os.environ.get("XDG_DATA_HOME", default=path.join(HOME, ".local", "share"))


def install_vscode_extensions(extensions: list[str]):
    installed = check_output(["code", "--list-extensions"]).decode("utf-8").splitlines()

    for extension in set(extensions) - set(installed):
        check_call(["code", "--install-extension", extension])

    extra = set(installed) - set(extensions)
    if len(extra) >= 1:
        print(f"{colored('Warning', color='yellow')}: extra VSCode extensions found")
        print("\n".join([f"• {ext}" for ext in extra]))


def install_pipx_packages(packages: list[str]) -> None:
    for package in packages:
        check_call(["uv", "tool", "install", "--quiet", package])


def install_gnome_shell_extensions(extensions: list[str]) -> None:
    installed = check_output(["gnome-extensions", "list"]).decode("utf-8").splitlines()
    for extension in set(extensions) - set(installed):
        install_gnome_shell_extension(extension)
    for extension in extensions:
        enable_gnome_shell_extension(extension)


def install_gnome_shell_extension(extension: str) -> None:
    check_call(
        [
            "busctl",
            "--user",
            "call",
            "org.gnome.Shell.Extensions",
            "/org/gnome/Shell/Extensions",
            "org.gnome.Shell.Extensions",
            "InstallRemoteExtension",
            "s",
            extension,
        ]
    )


def enable_gnome_shell_extension(extension: str) -> None:
    check_call(
        [
            "gnome-extensions",
            "enable",
            extension,
        ]
    )


def is_gnome():
    return (
        "XDG_CURRENT_DESKTOP" in environ and environ["XDG_CURRENT_DESKTOP"] == "GNOME"
    )


def file_list_from_node(symlink_node: kdl.Node) -> list[str]:
    return [node.name for node in nodes_for_current_os(symlink_node.nodes)]


def nodes_for_current_os(nodes: list[kdl.Node]) -> list[kdl.Node]:
    return [
        node
        for node in nodes
        if "os" not in node.props or node.props["os"] == platform.system()
    ]


HOME = str(Path.home())


def makedirs(path):
    os.makedirs(path, exist_ok=True)


def pretty_path(path: str) -> str:
    return path.replace(HOME, "~", 1) if path.startswith(HOME) else path


if __name__ == "__main__":
    install()
