return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  lazy = false,
  config = function()
    require("oil").setup {
      float = {
        max_width = 0.8,
        max_height = 0.8
      }
    }
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "<leader>-", require("oil").toggle_float)
  end
}
