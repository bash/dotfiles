from pathlib import Path
from typing import Optional
from typing import List
import os
import tomllib
import shutil
from subprocess import check_call
import gi
from gi.repository import GLib

_APPLICATIONS_DIR = Path("applications")
_MIME_DIR = Path("mime")
_DESKTOP_GROUP = "Desktop Entry"
_OZONE_PLATFORM_HINT = '--ozone-platform-hint=auto'


def patch_desktop_files():
    config = _load_config()
    patched = False
    assert isinstance(config, dict)
    for app_id, app_config in config.items():
        assert isinstance(app_config, dict)
        original = _find_original_xdg_data_file(_desktop_file_path(app_id))
        destination = _xdg_data_home() / _desktop_file_path(app_id)
        if original is not None:
            print(f'{original} -> {destination}')
            patched = True
            os.makedirs(destination.parent, exist_ok=True)
            shutil.copy2(original, destination)
            _edit_desktop_file(destination, app_config)
    if patched:
        _update_desktop_database()
        _update_mime_database()


def _edit_desktop_file(path: Path, actions: list) -> None:
    f = GLib.KeyFile()
    assert f.load_from_file(str(path), GLib.KeyFileFlags.NONE)
    for key, action in actions.items():
        if type(action) is str:
            f.set_string(_DESKTOP_GROUP, key, action)
        if isinstance(action, dict) and "remove" in action:
            f.remove_key(_DESKTOP_GROUP, key)
        if isinstance(action, dict) and "electron" in action:
            current_value = f.get_string(_DESKTOP_GROUP, key)
            f.set_string(_DESKTOP_GROUP, key, f'{current_value} {_OZONE_PLATFORM_HINT}')
    assert f.save_to_file(str(path))


def _load_config():
    with open("desktop-files.toml", "rb") as f:
        return tomllib.load(f)


def _find_original_xdg_data_file(relative_path: Path) -> Optional[Path]:
    return next(
        (
            dir / relative_path
            for dir in _xdg_data_dirs()
            if (dir / relative_path).exists()
        ),
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
    return (
        Path(xdg_data_home)
        if xdg_data_home is not None
        else Path.home() / ".local" / "share"
    )


def _update_desktop_database() -> None:
    check_call(["update-desktop-database", _xdg_data_home() / _APPLICATIONS_DIR])


def _update_mime_database() -> None:
    mime_path = _xdg_data_home() / _MIME_DIR
    os.makedirs(mime_path, exist_ok=True)
    check_call(["update-mime-database", mime_path])


if __name__ == "__main__":
    patch_desktop_files()
