from typing import List, Union, Sequence
from .diff import diff
from .extension import Extension, RequestedExtension
from .dbus_api import (
    disable_extension,
    enable_extension,
    install_remote_extension,
    list_extensions,
    uninstall_extension,
    get_user_extensions_enabled,
)
from .plan import Plan, plan
from os import environ


def apply(requested: List[RequestedExtension]) -> None:
    if _is_gnome():
        if not get_user_extensions_enabled():
            print(
                "\x1b[32m\x1b[1merror: user extensions are not enabled, skipping\x1b[0m"
            )
            return
        available = list_extensions()
        planned = plan(diff(available, requested))
        _print_plan(planned)
        if not planned.is_empty() and _confirm():
            print("Applying changes ", end="", flush=True)
            _execute(planned)
            print("[\x1b[32mok\x1b[0m]")


def _execute(plan: Plan):
    for ext in plan.install:
        install_remote_extension(ext.uuid)
    for ext in plan.enable:
        enable_extension(ext.uuid)
    for ext in plan.disable:
        disable_extension(ext.uuid)
    for ext in plan.uninstall:
        uninstall_extension(ext.uuid)


def _is_gnome() -> bool:
    return (
        "XDG_CURRENT_DESKTOP" in environ and environ["XDG_CURRENT_DESKTOP"] == "GNOME"
    )


def _print_plan(plan: Plan) -> None:
    if plan.is_empty():
        print("GNOME Shell Extensions are up-to-date")
    else:
        print("Changing GNOME Shell Extensions:")
        _print_action(plan.install, "Installing")
        _print_action(plan.uninstall, "Removing")
        _print_action(plan.enable, "Enabling")
        _print_action(plan.disable, "Disabling")


def _print_action(
    affected: Sequence[Union[Extension, RequestedExtension]], label: str
) -> None:
    if any(affected):
        print(f"  {label}:")
        for ext in affected:
            if type(ext) == Extension:
                print(f"    • {ext.name} ({ext.uuid})")
            else:
                print(f"    • {ext.uuid}")


def _confirm():
    try:
        answer = input("Is this ok [y/n]: ")
        return answer.lower() == "y"
    except KeyboardInterrupt:
        return False
