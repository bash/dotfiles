from typing import List
import gi
from gi.repository import Gio
from gi.repository.Gio import DBusProxy, BusType, DBusProxyFlags, DBusCallFlags
from gi.repository.GLib import Variant
from .extension import Extension, ExtensionType


SERVICE = "org.gnome.Shell.Extensions"
OBJECT = "/org/gnome/Shell/Extensions"
INTERFACE = "org.gnome.Shell.Extensions"


def get_user_extensions_enabled() -> bool:
    proxy = _get_extensions_proxy()
    return proxy.get_cached_property("UserExtensionsEnabled").unpack()


def list_extensions() -> List[Extension]:
    proxy = _get_extensions_proxy()
    (result,) = proxy.call_sync(
        "ListExtensions", None, DBusCallFlags.NONE, -1, None
    ).unpack()
    return [_to_extension(ext) for _, ext in result.items()]


def enable_extension(uuid: str) -> None:
    proxy = _get_extensions_proxy()
    (result,) = proxy.call_sync(
        "EnableExtension", Variant("(s)", (uuid,)), DBusCallFlags.NONE, -1, None
    )
    if not result:
        raise Exception(f"Failed to enable extension '{uuid}'")


def disable_extension(uuid: str) -> None:
    proxy = _get_extensions_proxy()
    (result,) = proxy.call_sync(
        "DisableExtension", Variant("(s)", (uuid,)), DBusCallFlags.NONE, -1, None
    )
    if not result:
        raise Exception(f"Failed to disable extension '{uuid}'")


def install_remote_extension(uuid: str) -> None:
    proxy = _get_extensions_proxy()
    (result,) = proxy.call_sync(
        "InstallRemoteExtension", Variant("(s)", (uuid,)), DBusCallFlags.NONE, -1, None
    )
    if not result:
        raise Exception(f"Failed to install remote extension '{uuid}'")


def uninstall_extension(uuid: str) -> None:
    proxy = _get_extensions_proxy()
    (result,) = proxy.call_sync(
        "UninstallExtension", Variant("(s)", (uuid,)), DBusCallFlags.NONE, -1, None
    )
    if not result:
        raise Exception(f"Failed to uninstall extension '{uuid}'")


def _to_extension(ext: dict) -> Extension:
    return Extension(
        uuid=ext["uuid"],
        name=ext["name"],
        type=ExtensionType(ext["type"]),
        enabled=ext["enabled"],
    )


def _get_extensions_proxy():
    return DBusProxy.new_for_bus_sync(
        BusType.SESSION, DBusProxyFlags.NONE, None, SERVICE, OBJECT, INTERFACE, None
    )
