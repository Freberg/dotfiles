return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  lazy = false,
  config = function()
    vim.opt.splitright = true
    require("oil").setup {
      win_options = {
        -- required for oil-git-status
        signcolumn = "yes:2",
      },
      view_options = {
        show_hidden = true,
      },
      float = {
        max_width = 0.8,
        max_height = 0.8
      },
      keymaps = {
        ["gs"] = {
          callback = function()
            local entry = require("oil").get_cursor_entry()
            local dir = require("oil").get_current_dir()
            if entry and dir then
              vim.fn.system({ "git", "add", vim.fs.joinpath(dir, entry.name) })
              require("oil-git-status").refresh_buffer(vim.api.nvim_get_current_buf())
              print("Staged: " .. entry.name)
            end
          end,
          desc = "Git stage",
        },
        ["gu"] = {
          callback = function()
            local entry = require("oil").get_cursor_entry()
            local dir = require("oil").get_current_dir()
            if entry and dir then
              vim.fn.system({ "git", "restore", "--staged", vim.fs.joinpath(dir, entry.name) })
              require("oil-git-status").refresh_buffer(vim.api.nvim_get_current_buf())
              print("Unstaged: " .. entry.name)
            end
          end,
          desc = "Git unstage",
        },
      },
    }

    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set('n', '<leader>-', function()
      if vim.w.is_oil_win then
        require('oil').close()
      else
        require('oil').open_float(nil, { preview = {} })
      end
    end, { desc = 'Toggle float file exlorer', silent = true })

    vim.api.nvim_create_autocmd("User", {
      pattern = "OilEnter",
      callback = function()
        -- update oil-git-status whenever a directory is entered, requied due to above git keybinds
        vim.schedule(function()
          local ok, ogs = pcall(require, "oil-git-status")
          if ok then
            ogs.refresh_buffer(vim.api.nvim_get_current_buf())
          end
        end)
        -- always open previews
        if vim.b.oil_preview_opened then return end
        require("oil").open_preview()
        vim.b.oil_preview_opened = true
      end,
    })
  end
}
