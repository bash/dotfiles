-- The file starts with 51- because we need to be loaded after 50-bluez-config.lua
-- which configures `bluez_monitor.properties`.

-- See: https://pipewire.pages.freedesktop.org/wireplumber/configuration/bluetooth.html
-- This property by default also includes the hfp_ag (Handsfree) role, which we don't want.
bluez_monitor.properties["bluez5.headset-roles"] = "[ hsp_hs ]"
