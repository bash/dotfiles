from os import environ
from pathlib import Path
from . import update_flatpak_aliases
import tomllib
from typing import Any

def _aliases_dir() -> Path:
    return _xdg_data_home() / 'flatpak-aliases'

def _xdg_data_home() -> Path:
    return (Path(environ['XDG_DATA_HOME']) if 'XDG_DATA_HOME' in environ else Path.home() / ".local" / "share")

def _load_config() -> Any:
    with open("flatpak-aliases.toml", "rb") as f:
        config = tomllib.load(f)
    return config["aliases"]


if __name__ == '__main__':
    update_flatpak_aliases(_aliases_dir(), _load_config())
