local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Catppuccin Frappe'
  else
    return 'Catppuccin Latte'
  end
end

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

config.window_background_opacity = 0.9
config.macos_window_background_blur = 30

config.font_size = 15

config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'

config.window_frame = {
  font_size = 14,
}

config.color_scheme = scheme_for_appearance(get_appearance())

return config
