require("config.lazy")

vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]

vim.opt.colorcolumn = "120"
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.clipboard = "unnamedplus"
