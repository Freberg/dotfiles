return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  lazy = false,
  config = function()
    vim.opt.splitright = true
    require("oil").setup {
      view_options = {
        show_hidden = true,
      },
      float = {
        max_width = 0.8,
        max_height = 0.8
      }
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
        if vim.b.oil_preview_opened then return end
        require("oil").open_preview()
        vim.b.oil_preview_opened = true
      end,
    })
  end
}
