local wezterm = require 'wezterm'
local M = {}

local THEME_ENV_FILE = wezterm.home_dir .. "/.config/theme/env/current"

local function extract_var(content, var_name)
  local pattern = "export%s+" .. var_name .. "=([^%\n]*)"
  local raw_val = content:match(pattern)
  if raw_val then
    return raw_val:gsub("['\"]", ""):gsub("^%s*", ""):gsub("%s*$", "")
  end
  return nil
end

function M.apply_theme(config)
  local file = io.open(THEME_ENV_FILE, "r")

  if file then
    local content = file:read("*all")
    file:close()

    local wez_theme = extract_var(content, "WEZTERM_THEME")
    local bat_theme = extract_var(content, "BAT_THEME")
    local nvim_theme = extract_var(content, "NVIM_THEME")

    if wez_theme then
      config.color_scheme = wez_theme
    end

    config.set_environment_variables = config.set_environment_variables or {}
    if wez_theme then config.set_environment_variables["WEZTERM_THEME"] = wez_theme end
    if bat_theme then config.set_environment_variables["BAT_THEME"] = bat_theme end
    if nvim_theme then config.set_environment_variables["NVIM_THEME"] = nvim_theme end
  end
end

return M
