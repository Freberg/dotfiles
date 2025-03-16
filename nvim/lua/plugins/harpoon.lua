return {
  "ThePrimeagen/harpoon",
  config = function()
    require("harpoon").setup()
  end,
  keys = {
    { "<leader>ha", function() require("harpoon.mark").add_file() end,        desc = "harpoon file" },
    { "<leader>he", function() require("harpoon.ui").toggle_quick_menu() end, desc = "harpoon quick menu" },
    { "<leader>1",  function() require("harpoon.ui").nav_file(1) end,         desc = "harpoon to file 1" },
    { "<leader>2",  function() require("harpoon.ui").nav_file(2) end,         desc = "harpoon to file 2" },
    { "<leader>3",  function() require("harpoon.ui").nav_file(3) end,         desc = "harpoon to file 3" },
    { "<leader>4",  function() require("harpoon.ui").nav_file(4) end,         desc = "harpoon to file 4" },
    { "<leader>5",  function() require("harpoon.ui").nav_file(5) end,         desc = "harpoon to file 5" },
  }
}
