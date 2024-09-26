local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Catppuccin Frappe'
  else
    return 'Catppuccin Latte'
  end
end

local font_family = 'Departure Mono'

config.window_background_opacity = 0.9
config.macos_window_background_blur = 30

config.font = wezterm.font(font_family)
config.font_size = 15

config.window_decorations = 'RESIZE'

config.window_frame = {
  font = wezterm.font({ family = font_family, weight = 'Bold' }),
  font_size = 14,
}

wezterm.on('window-config-reloaded', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  local appearance = window:get_appearance()
  local scheme = scheme_for_appearance(appearance)
  if overrides.color_scheme ~= scheme then
    overrides.color_scheme = scheme
    window:set_config_overrides(overrides)
  end
end)

return config
