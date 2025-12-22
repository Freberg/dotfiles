return {
  "neanias/everforest-nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd([[colorscheme everforest]])
    vim.o.background = "dark"
  end,
}
