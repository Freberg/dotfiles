local wezterm = require 'wezterm'
local M = {}

local HARDWARE_POLL_INTERVAL = 5
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider


local function cpu_component()
  local CPU = {}
  local last_update_time = 0
  local last_value = ''
  local last_metrics = nil
  CPU.update = function()
    local current_time = os.time()
    if last_metrics ~= nil and current_time - last_update_time < HARDWARE_POLL_INTERVAL then
      return last_value
    end

    local success, result = wezterm.run_child_process {
      'bash', '-c',
      'grep cpu /proc/stat | awk \'NR==1{idle=($5+$6)} NR==1{nonidle=($2+$3+$4+$7+$8+$9)} END {print idle, nonidle, FNR-1}\''
    }
    if not success or not result then
      return ''
    end

    local metrics = {}
    for w in result:gmatch("%w+") do
      table.insert(metrics, tonumber(w))
    end
    if last_metrics == nil then
      last_metrics = metrics
      return last_value
    end

    local total_diff = metrics[1] + metrics[2] - last_metrics[1] - last_metrics[2]
    local idle_diff = metrics[1] - last_metrics[1]
    local percentage = (total_diff - idle_diff) / total_diff
    local cores = percentage * metrics[3]

    last_value = string.format('  %.2f(%.2f%%)', cores, percentage * 100)
    last_metrics = metrics
    last_update_time = current_time
    return last_value
  end
  return CPU
end

local function memory_component()
  local MEMORY = {}
  local last_update_time = 0
  local last_value = ''
  MEMORY.update = function()
    local current_time = os.time()
    if current_time - last_update_time < HARDWARE_POLL_INTERVAL then
      return last_value
    end

    local success, result = wezterm.run_child_process {
      'bash', '-c', 'free -m | awk \'NR==2{printf "  %.2fGB(%.2f%%)", $3/1000, $3/$2*100}\''
    }
    if not success or not result then
      return ''
    end

    last_value = result
    last_update_time = current_time
    return last_value
  end
  return MEMORY
end

local function network_component()
  local NETWORK = {}
  local last_update_time = 0
  local last_value = ''
  local last_metrics = nil
  NETWORK.update = function()
    local current_time = os.time()
    if last_metrics ~= nil and current_time - last_update_time < HARDWARE_POLL_INTERVAL then
      return last_value
    end

    local success, result = wezterm.run_child_process {
      'bash', '-c',
      'awk \'NR>2{rx+=$2;tx=$10} END {print rx, tx}\' /proc/net/dev'
    }
    if not success or not result then
      return ''
    end

    local metrics = {}
    for w in result:gmatch("%w+") do
      table.insert(metrics, tonumber(w) / 1000)
    end
    if last_metrics == nil then
      last_metrics = metrics
      return last_value
    end

    last_value = string.format('󰇚 %.0fkbps 󰕒 %.0fkbps',
      (metrics[1] - last_metrics[1]) / (current_time - last_update_time),
      (metrics[2] - last_metrics[2]) / (current_time - last_update_time)
    )
    last_metrics = metrics
    last_update_time = current_time
    return last_value
  end
  return NETWORK
end

function M.setup(config)
  local color_scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]
  local colors = {
    background = color_scheme.background,
    foreground = color_scheme.foreground,
    black = color_scheme.ansi[1],
    red = color_scheme.ansi[2],
    green = color_scheme.ansi[3],
    yellow = color_scheme.ansi[4],
    blue = color_scheme.ansi[5],
    magenta = color_scheme.ansi[6],
    cyan = color_scheme.ansi[7],
    white = color_scheme.ansi[8],
  }

  config.use_fancy_tab_bar = false
  config.colors = {
    tab_bar = {
      background = colors.background,
      active_tab = {
        bg_color = colors.background,
        fg_color = colors.foreground
      },
      inactive_tab = {
        bg_color = colors.black,
        fg_color = colors.foreground
      }
    }
  }

  local cpu = cpu_component()
  local memory = memory_component()
  local network = network_component()

  local function update_cell(foreground, background, text)
    return {
      { Foreground = { Color = background } },
      { Text = SOLID_LEFT_ARROW },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = text },
    }
  end

  wezterm.on('update-right-status', function(window)
    local cells = {
      update_cell(colors.background, colors.yellow, ' ' .. network.update() .. ' '),
      update_cell(colors.background, colors.blue, ' ' .. memory.update() .. ' ' .. cpu.update() .. ' '),
      update_cell(colors.foreground, colors.black, '  ' .. wezterm.time.now():format('%H:%M') .. ' ')
    }

    local layout = {}
    for _, cell in ipairs(cells) do
      for _, format_item in ipairs(cell) do
        table.insert(layout, format_item)
      end
    end

    window:set_right_status(wezterm.format(layout))
  end)
end

return M
