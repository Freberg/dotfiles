local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.font_size = 10.0
config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.window_background_opacity = 0.5
config.color_scheme = 'nord'

return config
