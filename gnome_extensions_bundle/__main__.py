from .extension import RequestedExtension
from . import apply
import tomllib
from typing import Any


def _load_config():
    with open("gnome-shell-extensions.toml", "rb") as f:
        config = tomllib.load(f)
    return [_requested_extension_from_toml(ext) for ext in config["extensions"]]


def _requested_extension_from_toml(value: Any) -> RequestedExtension:
    match value:
        case str():
            return RequestedExtension(uuid=value, install=True)
        case dict():
            uuid = value["uuid"]
            install = value.get("install", True)
            return RequestedExtension(uuid=uuid, install=install)
        case _:
            raise Exception(f"Unsupported type '{type(value)}'")


if __name__ == "__main__":
    apply(_load_config())
