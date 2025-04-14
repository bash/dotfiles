from .extension import RequestedExtension
from . import apply
import tomllib


def _load_config():
    with open("gnome-shell-extensions.toml", "rb") as f:
        config = tomllib.load(f)
    return [RequestedExtension(uuid=ext) for ext in config["extensions"]]


if __name__ == "__main__":
    apply(_load_config())
