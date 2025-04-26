#!/usr/bin/env python3

from subprocess import check_call, call, check_output, CalledProcessError
from os import path
from gi.repository import Gio
from gi.repository import GLib

_IMAGE_NAME = 'taus-toolbox'
_CONTAINER_NAME = 'taus-toolbox'

def update_toolbox(source_dir: str):
    check_call(['podman', 'build', '--tag', _IMAGE_NAME, source_dir])
    _rename_current_container()
    _cleanup_old_containers()
    call(['toolbox', 'create', '--image', _IMAGE_NAME, _CONTAINER_NAME])
    _set_default_container(_get_container_id(_CONTAINER_NAME))

def _cleanup_old_containers():
    containers = check_output(['podman', 'ps', '-a', '--filter', f'name={_CONTAINER_NAME}-obsolete-', '--format', "{{.ID}}"]).decode().splitlines()
    for container in containers:
        _remove_container(container)

def _remove_container(container: str):
    try:
        check_call(['podman', 'rm', container])
    except CalledProcessError:
        pass

def _rename_current_container() -> None:
    try:
        id = _get_container_id(_CONTAINER_NAME)
        check_call(['podman', 'rename', _CONTAINER_NAME, f'{_CONTAINER_NAME}-obsolete-{id}'])
    except CalledProcessError:
        pass

def _get_container_id(name: str) -> str:
    return check_output(['podman', 'inspect', '--format', '{{.Id}}', name]).decode().strip()

def _set_default_container(container_id: str) -> None:
    ptyxis_settings = Gio.Settings.new_with_path('org.gnome.Ptyxis', '/org/gnome/Ptyxis/')
    default_profile = ptyxis_settings.get_user_value('default-profile-uuid').unpack()
    profile_settings = Gio.Settings.new_with_path('org.gnome.Ptyxis.Profile', f'/org/gnome/Ptyxis/Profiles/{default_profile}/')
    profile_settings.set_value('default-container', GLib.Variant('s', container_id))

if __name__ == "__main__":
    update_toolbox(path.join(path.dirname(__file__)))
