-- Why does the file start with 51- you ask?
-- Because WirePlumber performs multi-path merging meaning that a lower numbered stock config
-- will run before your new script, as alphanumeric ordering takes
-- precedence over directory priorities. See: https://wiki.archlinux.org/title/WirePlumber#Modifying_the_configuration
--
-- In our case we want to run after the alsa_monitor is created, which happens
-- in 50-alsa-config.lua: https://gitlab.freedesktop.org/pipewire/wireplumber/-/blob/master/src/config/main.lua.d/50-alsa-config.lua

-- Some (minimal) documentation on ALSA Configuration can be found here:
-- https://pipewire.pages.freedesktop.org/wireplumber/configuration/alsa.html

-- Some good tools for listing pipewire objects are `wpctl status` (and a subsequent `wpctl inspect ID` for details)
-- and `pactl list` (which can also be restricted to objects of a certain type, see `pactl list -h` for a list of possibilities).


-- This rule disables all sound devices coming from a webcam.
rule = {
  matches = {
    {
      { "device.subsystem", "equals", "sound" },
      { "device.form-factor", "equals", "webcam" },
    },
  },
  apply_properties = {
    ["device.disabled"] = true,
  },
}
table.insert(alsa_monitor.rules, rule)
