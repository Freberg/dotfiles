local M = {}
local selected_files = {}
local selection_buf, selection_win

local function submit(paths)
  local out_file = vim.env.NVIM_FILE_CHOOSER_OUT_FILE
  if not out_file or #paths == 0 then return end

  local f = io.open(out_file, "w")
  if f then
    f:write(table.concat(paths, "\n"))
    f:close()
  end
  vim.cmd("qall!")
end


local function update_selection_ui()
  local paths = {}
  for path, _ in pairs(selected_files) do
    table.insert(paths, " " .. vim.fn.fnamemodify(path, ":t"))
  end

  if not selection_buf or not vim.api.nvim_buf_is_valid(selection_buf) then
    selection_buf = vim.api.nvim_create_buf(false, true)
  end

  vim.api.nvim_buf_set_lines(selection_buf, 0, -1, false, #paths > 0 and paths or { " (No selection)" })

  local width = 30
  local height = math.min(#paths + 2, 15)
  local row = vim.o.lines - height - 5
  local col = vim.o.columns - width - 2

  if not selection_win or not vim.api.nvim_win_is_valid(selection_win) then
    selection_win = vim.api.nvim_open_win(selection_buf, false, {
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
      style = "minimal",
      border = "single",
      title = " Selected ",
      title_pos = "center",
    })
  else
    vim.api.nvim_win_set_config(selection_win, {
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col
    })
  end
end

function M.setup_oil_keybinds()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "oil",
    callback = function()
      local oil = require("oil")
      local is_multi = vim.env.NVIM_FILE_CHOOSER_MULTI == "1"
      local is_dir_mode = vim.env.NVIM_FILE_CHOOSER_DIR == "1"
      local is_save_mode = vim.env.NVIM_FILE_CHOOSER_SAVE == "1"

      vim.keymap.set("n", "<Tab>", function()
        local entry = oil.get_cursor_entry()
        local dir = oil.get_current_dir()

        if not entry then return end

        if is_dir_mode and entry.type ~= "directory" then
          vim.notify("Directory selection required", vim.log.levels.WARN)
          return
        end

        if not is_dir_mode and entry.type == "directory" then
          vim.notify("File selection required", vim.log.levels.WARN)
          return
        end

        local full_path = dir .. entry.name

        if is_save_mode then
          submit({ full_path })
          return
        end

        if not is_multi then
          submit({ full_path })
        else
          if selected_files[full_path] then
            selected_files[full_path] = nil
            vim.api.nvim_buf_clear_namespace(0, -1, vim.fn.line('.') - 1, vim.fn.line('.'))
          else
            selected_files[full_path] = true
            vim.api.nvim_buf_add_highlight(0, -1, "Visual", vim.fn.line('.') - 1, 0, -1)
          end
          update_selection_ui()
        end
      end, { buffer = true })

      vim.keymap.set({"n", "v"}, "<C-s>", function()
        local dir = oil.get_current_dir()

        local final_paths = {}
        for path, _ in pairs(selected_files) do
          table.insert(final_paths, path)
        end

        if #final_paths > 0 then
          submit(final_paths)
        else
          submit({ dir })
        end
      end, { buffer = true })
    end
  })
end

M.setup_oil_keybinds()

return M
