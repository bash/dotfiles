from pathlib import Path
from typing import Optional
from typing import List
import os
import tomllib
import shutil
from subprocess import check_call
import gi
from gi.repository import GLib

_APPLICATIONS_DIR = Path('applications')

def patch_desktop_files():
    config = _load_config()
    patched = False
    assert(type(config) == dict)
    for app_id, app_config in config.items():
        assert(type(app_config) == dict)
        original = _find_original_xdg_data_file(_desktop_file_path(app_id))
        if original is not None:
            patched = True
            destination = _xdg_data_home() / _desktop_file_path(app_id)
            os.makedirs(destination.parent, exist_ok=True)
            shutil.copy2(original, destination)
            for key, action in app_config.items():
                if type(action) == str:
                    check_call(['desktop-file-edit', f'--set-key={key}', f'--set-value={action}'])
                elif type(action) == dict and 'remove' in action:
                    check_call(['desktop-file-edit'])
                else:
                    raise Exception(f"Unsupported config at {app_id}.{key} = {action}")
    if patched:
        _update_desktop_database()

def _load_config():
    with open("desktop-files.toml", "rb") as f:
        return tomllib.load(f)

def _find_original_xdg_data_file(relative_path: Path) -> Optional[Path]:
    return next(
        (dir / relative_path for dir in _xdg_data_dirs() if (dir / relative_path).exists()),
        None,
    )

def _xdg_data_dirs() -> List[Path]:
    data_dirs = os.environ.get("XDG_DATA_DIRS", default="/usr/local/share:/usr/share")
    return [Path(data_dir) for data_dir in data_dirs.split(":")]

def _desktop_file_name(app_id: str) -> str:
    return f"{app_id}.desktop"

def _desktop_file_path(app_id: str) -> Path:
    return _APPLICATIONS_DIR / _desktop_file_name(app_id)

def _xdg_data_home() -> Path:
    xdg_data_home = os.environ.get("XDG_DATA_HOME")
    return Path(xdg_data_home) if xdg_data_home is not None else Path.home() / ".local" / ".share"

def _update_desktop_database() -> None:
    check_call(['update-desktop-database', _xdg_data_home() / _APPLICATIONS_DIR])

if __name__ == "__main__":
    patch_desktop_files()
