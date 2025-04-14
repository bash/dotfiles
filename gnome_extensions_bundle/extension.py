from dataclasses import dataclass
from enum import Enum


class ExtensionType(Enum):
    SYSTEM = 1
    USER = 2


@dataclass(frozen=True, kw_only=True)
class Extension:
    uuid: str
    name: str
    type: ExtensionType
    enabled: bool


@dataclass(frozen=True, kw_only=True)
class RequestedExtension:
    uuid: str
