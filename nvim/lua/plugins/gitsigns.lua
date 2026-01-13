return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require('gitsigns').setup()
  end,
  keys = {
    {
      "<leader>ba",
      "<CMD>Gitsigns<CR>",
      mode = { "n", "x" },
      desc = "Open gitsigns actions",
    },
    {
      "<leader>bb",
      "<CMD>Gitsigns blame<CR>",
      mode = { "n", "x" },
      desc = "Open gitsigns blame",
    },
  }
}
