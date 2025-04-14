from .diff import Diff
from .extension import Extension, ExtensionType, RequestedExtension
from typing import List
from dataclasses import dataclass


@dataclass(frozen=True, kw_only=True)
class Plan:
    install: List[RequestedExtension]
    uninstall: List[Extension]
    enable: List[Extension]
    disable: List[Extension]

    def is_empty(self) -> bool:
        return not any(self.install + self.uninstall + self.enable + self.disable)


def plan(diff: Diff) -> Plan:
    return Plan(
        install=diff.not_installed,
        enable=diff.not_enabled,
        uninstall=[ext for ext in diff.extra if ext.type == ExtensionType.USER],
        disable=[
            ext
            for ext in diff.extra
            if ext.type == ExtensionType.SYSTEM and ext.enabled
        ],
    )
