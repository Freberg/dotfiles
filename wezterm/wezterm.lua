local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

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

config.keys = {
  { key = 'r',          mods = 'ALT', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false } },

  { key = 'q',          mods = 'ALT', action = act.SplitPane { direction = 'Down', size = { Percent = 20 } } },
  { key = 'e',          mods = 'ALT', action = act.SplitPane { direction = 'Right', size = { Percent = 30 } } },
  { key = 'w',          mods = 'ALT', action = act.TogglePaneZoomState },
  { key = '+',          mods = 'ALT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '-',          mods = 'ALT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'c',          mods = 'ALT', action = act.CloseCurrentPane { confirm = true } },

  { key = 'LeftArrow',  mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
  { key = 'h',          mods = 'ALT', action = act.ActivatePaneDirection 'Left' },

  { key = 'RightArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
  { key = 'l',          mods = 'ALT', action = act.ActivatePaneDirection 'Right' },

  { key = 'UpArrow',    mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
  { key = 'k',          mods = 'ALT', action = act.ActivatePaneDirection 'Up' },

  { key = 'DownArrow',  mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
  { key = 'j',          mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
}

config.key_tables = {
  resize_pane = {
    { key = 'LeftArrow',  action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'h',          action = act.AdjustPaneSize { 'Left', 1 } },

    { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'l',          action = act.AdjustPaneSize { 'Right', 1 } },

    { key = 'UpArrow',    action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'k',          action = act.AdjustPaneSize { 'Up', 1 } },

    { key = 'DownArrow',  action = act.AdjustPaneSize { 'Down', 1 } },
    { key = 'j',          action = act.AdjustPaneSize { 'Down', 1 } },

    { key = 'Escape',     action = 'PopKeyTable' },
  },
}

return config
