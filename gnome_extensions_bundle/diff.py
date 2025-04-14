from .extension import Extension, RequestedExtension
from typing import List
from dataclasses import dataclass


@dataclass(frozen=True, kw_only=True)
class Diff:
    not_installed: List[RequestedExtension]
    extra: List[Extension]
    not_enabled: List[Extension]


def diff(available: List[Extension], requested: List[RequestedExtension]) -> Diff:
    available_by_uuid = {ext.uuid: ext for ext in available}
    requested_by_uuid = {ext.uuid: ext for ext in requested}
    not_installed = [
        requested_by_uuid[uuid]
        for uuid in requested_by_uuid.keys() - available_by_uuid.keys()
    ]
    extra = [
        available_by_uuid[uuid]
        for uuid in available_by_uuid.keys() - requested_by_uuid.keys()
    ]
    not_enabled = [
        available_by_uuid[uuid]
        for uuid in requested_by_uuid.keys() & available_by_uuid.keys()
        if not available_by_uuid[uuid].enabled
    ]
    return Diff(not_installed=not_installed, extra=extra, not_enabled=not_enabled)
