return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd([[colorscheme gruvbox]])
    vim.o.background = "dark"
  end,
}
