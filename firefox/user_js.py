from typing import Iterable
from pathlib import Path
import os.path
import sys
from subprocess import check_call


def get_user_js_symlinks() -> list[tuple[Path, Path]]:
    user_js_src = Path(__file__).parent / "user.js"
    return [
        (user_js_src, directory / "user.js")
        for directory in _get_profile_directories()
    ]

def grant_flatpaked_firefox_access_to_user_js() -> None:
    firefox_dir_path = Path(__file__).parent
    firefox_dir = str(firefox_dir_path).replace(str(Path.home()), 'home')
    try:
        check_call(['flatpak', 'override', '--user', f'--filesystem={firefox_dir}', 'org.mozilla.firefox'])
    except FileNotFoundError:
        pass


# Shamelessly stolen from https://github.com/kurtmckee/dotbot-firefox
# licensed under the MIT license.
def _get_profile_directories() -> Iterable[Path]:
    """Yield Firefox profile directories that appear to be valid."""

    defaults: list[str] = []

    if sys.platform.startswith("win32"):  # Windows
        defaults.append("${APPDATA}/Mozilla/Firefox/Profiles")
    elif sys.platform.startswith("darwin"):  # MacOS
        defaults.append("~/Library/Application Support/Firefox/Profiles")
    else:
        defaults.append("~/.mozilla/firefox")

        # When Firefox is installed and run as a snap,
        # it stores its profile info under $SNAP_USER_COMMON.
        #
        # It might be more correct to introspect $SNAP_USER_COMMON,
        # in case it's been customized, using a command like:
        #
        #     snap run --shell firefox -c 'echo $SNAP_USER_COMMON'
        #
        # ...but that seems unnecessary, and may be fragile and insecure.
        #
        snap_user_common = "~/snap/firefox/common"
        defaults.append(f"{snap_user_common}/.mozilla/firefox")

        # When Firefox is installed and run as a flatpak,
        # it stores its profile info under this directory:
        #
        #     $HOME/.var/app/org.mozilla.firefox
        #
        # $HOME can be customized inside the flatpak sandbox environment,
        # but it seems unlikely that this level of customization will be needed.
        #
        flatpak_home = "~/.var/app/org.mozilla.firefox"
        defaults.append(f"{flatpak_home}/.mozilla/firefox")

    for default in defaults:
        path = Path(os.path.expandvars(os.path.expanduser(default)))
        if not path.is_dir():
            continue

        for profile in path.glob("*"):
            if profile.is_dir() and (profile / "prefs.js").is_file():
                yield profile
