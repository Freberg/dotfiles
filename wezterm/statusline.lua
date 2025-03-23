local wezterm = require 'wezterm'
local M = {}

local HARDWARE_POLL_INTERVAL = 1
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local COLORS = {
  background = '#2E3440',
  foreground = '#D8DEE9',
  black = '#3B4252',
  red = '#BF616A',
  green = '#A3BE8C',
  yellow = '#EBCB8B',
  blue = '#81A1C1',
  magenta = '#B48EAD',
  cyan = '#88C0D0',
  white = '#E5E9F0'
}

local function cpu_component()
  local CPU = {}
  local last_update_time = 0
  local last_value = ''
  local last_metrics
  CPU.update = function()
    local current_time = os.time()
    if last_value ~= '' and current_time - last_update_time < HARDWARE_POLL_INTERVAL then
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
      return ''
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
  local last_metrics
  NETWORK.update = function()
    local current_time = os.time()
    if last_value ~= '' and current_time - last_update_time < HARDWARE_POLL_INTERVAL then
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
      last_update_time = current_time
      return ''
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

function M.set_recommended(config)
  config.use_fancy_tab_bar = false
  config.colors = {
    tab_bar = {
      background = COLORS.background,
      active_tab = {
        bg_color = COLORS.background,
        fg_color = COLORS.foreground
      },
      inactive_tab = {
        bg_color = COLORS.black,
        fg_color = COLORS.foreground
      }
    }
  }
end

function M.setup()
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
      update_cell(COLORS.background, COLORS.yellow, ' ' .. network.update() .. ' '),
      update_cell(COLORS.background, COLORS.blue, ' ' .. memory.update() .. ' ' .. cpu.update() .. ' '),
      update_cell(COLORS.foreground, COLORS.black, '  ' .. wezterm.time.now():format('%H:%M') .. ' ')
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
