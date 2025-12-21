local wezterm = require 'wezterm'

local PROMPT_INDICATOR = "[%$]"
local MARKDOWN_LANG = "bash"

wezterm.on('copy-last-command-markdown', function(window, pane)
  local dims = pane:get_dimensions()
  local text = pane:get_text_from_region(0, dims.scrollback_rows - 150, dims.cols, dims.scrollback_rows + dims.viewport_rows)
  local lines = {}
  for line in text:gmatch("([^\n]*)\n?") do table.insert(lines, line) end
  local current_idx, prev_idx = nil, nil

  for i = #lines, 1, -1 do
    if lines[i]:find(PROMPT_INDICATOR) then
      if not current_idx then current_idx = i else prev_idx = i break end
    end
  end

  if prev_idx and current_idx then
    local command_part = lines[prev_idx]:match(".*" .. PROMPT_INDICATOR .. "%s*(.-)%s*$") or ""

    local output = {}
    for j = prev_idx + 1, current_idx - 1 do
      table.insert(output, lines[j])
    end

    local clean_output = table.concat(output, "\n"):gsub("^%s+", ""):gsub("%s+$", "")
    local markdown = string.format("```%s\n$ %s\n%s\n```", MARKDOWN_LANG, command_part, clean_output)

    window:copy_to_clipboard(markdown, 'Clipboard')
    window:toast_notification('WezTerm', 'Markdown Copied!', nil, 2000)
  else
    window:toast_notification('WezTerm', 'Prompt boundaries not found', nil, 3000)
  end
end)
