local wezterm = require 'wezterm'
local statusline = require 'statusline'
local theme_switcher = require 'theme_switcher'
local copycommand = require 'copycommand'
local config = wezterm.config_builder()
local act = wezterm.action

config.mux_enable_ssh_agent = false

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

--config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.show_close_tab_button_in_tabs = false
config.show_new_tab_button_in_tab_bar = false
config.window_frame = {
  font_size = 8.0,
  font = wezterm.font { family = 'JetBrainsMono Nerd Font', weight = 'Bold' }
}

config.font_size = 10.0
config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.window_background_opacity = 0.85
config.color_scheme = os.getenv('WEZTERM_THEME')
theme_switcher.apply_theme(config)

config.keys = {
  { key = 'r', mods = 'ALT', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false } },
  { key = 'x', mods = 'ALT', action = act.ActivateCopyMode },

  { key = 'a', mods = 'ALT', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = '1', mods = 'ALT', action = act.ActivateTab(0) },
  { key = '2', mods = 'ALT', action = act.ActivateTab(1) },
  { key = '3', mods = 'ALT', action = act.ActivateTab(2) },
  { key = '4', mods = 'ALT', action = act.ActivateTab(3) },
  { key = '5', mods = 'ALT', action = act.ActivateTab(4) },

  { key = 'q', mods = 'ALT', action = act.SplitPane { direction = 'Down', size = { Percent = 20 } } },
  { key = 'e', mods = 'ALT', action = act.SplitPane { direction = 'Right', size = { Percent = 30 } } },
  { key = 'w', mods = 'ALT', action = act.TogglePaneZoomState },
  { key = '+', mods = 'ALT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '-', mods = 'ALT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'c', mods = 'ALT', action = act.CloseCurrentPane { confirm = true } },

  { key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },

  { key = 'y', mods = 'ALT', action = act.EmitEvent 'copy-last-command-markdown' },
}

config.key_tables = {
  copy_mode = {
    { key = 'h', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
    { key = 'j', mods = 'NONE', action = act.CopyMode 'MoveDown' },
    { key = 'k', mods = 'NONE', action = act.CopyMode 'MoveUp' },
    { key = 'l', mods = 'NONE', action = act.CopyMode 'MoveRight' },

    { key = 'z', mods = 'NONE', action = act.CopyMode 'MoveBackwardSemanticZone' },
    { key = 'Z', mods = 'NONE', action = act.CopyMode 'MoveForwardSemanticZone' },
    { key = 'z', mods = 'CTRL', action = act.CopyMode { SetSelectionMode = 'SemanticZone' } },
    { key = 'z', mods = 'ALT',  action = act.CopyMode { MoveBackwardZoneOfType = 'Output' } },
    { key = 'Z', mods = 'ALT',  action = act.CopyMode { MoveForwardZoneOfType = 'Output' } },

    {
      key = 'y',
      mods = 'NONE',
      action = act.Multiple {
        { CopyTo = 'ClipboardAndPrimarySelection' },
        { CopyMode = 'MoveToScrollbackBottom' },
        { CopyMode = 'Close' },
      },
    },
    {
      key = 'Escape',
      modes = 'NONE',
      action = act.Multiple {
        { CopyMode = 'MoveToScrollbackBottom' },
        { CopyMode = 'Close' } }
    },
    {
      key = 'q',
      modes = 'NONE',
      action = act.Multiple {
        { CopyMode = 'MoveToScrollbackBottom' },
        { CopyMode = 'Close' } }
    },
  },
  resize_pane = {
    { key = 'h',      action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'l',      action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'k',      action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'j',      action = act.AdjustPaneSize { 'Down', 1 } },

    { key = 'Escape', action = 'PopKeyTable' },
  },
}

statusline.setup(config)

return config
