from pathlib import Path
from subprocess import check_output, check_call
from typing import List
from typing import Optional
from os import listdir, makedirs, remove

def update_flatpak_aliases(target_dir: Path, aliases: dict[str, str]) -> None:
    installed = _get_installed_application_ids()
    if installed is not None:
        _remove_existing_aliases(target_dir)
        installable = _get_installable_aliases(aliases, set(installed))
        _install_aliases(installable, target_dir)

def _get_installed_application_ids() -> Optional[List[str]]:
    try:
        raw_output = check_output(['flatpak', 'list', '--columns=application'])
        header_and_ids = raw_output.decode().splitlines()
        return header_and_ids[1:]
    except FileNotFoundError:
        return None

def _remove_existing_aliases(dir: Path) -> None:
    try:
        aliases = [(dir / f) for f in listdir(dir) if (dir / f).is_file()]
    except FileNotFoundError:
        return
    for alias in aliases:
        remove(alias)


def _get_installable_aliases(requested: dict[str, str], installed: set[str]) -> dict[str,str]:
    return {alias:app_id for alias,app_id in requested.items() if app_id in installed}

def _install_aliases(aliases: dict[str,str], dir: Path):
    arch = _get_default_arch()
    if any(aliases):
        makedirs(dir, exist_ok=True)
    for alias, app_id in aliases.items():
        alias_path = dir / alias
        with open(alias_path, "x") as f:
            f.write(_shim(app_id, arch))
        check_call(['chmod', '+x', '--', alias_path])

def _get_default_arch():
    return check_output(['flatpak', '--default-arch']).decode().strip()

def _shim(app_id: str, arch: str) -> str:
    return f"""#!/bin/sh
exec flatpak run --arch={arch} {app_id} "$@"
"""
