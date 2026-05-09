-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

if vim.env.NVIM_THEME == nil then vim.env.NVIM_THEME = "nord" end

-- Check nvim mode
local is_file_chooser = vim.env.NVIM_FILE_CHOOSER == "1"
local plugin_spec = {}
if is_file_chooser then
  plugin_spec = {
    { import = "plugins.themes" },
    { import = "plugins.oil" },
    { import = "plugins.telescope" },
  }
else
  plugin_spec = {
    { import = "plugins.themes" },
    { import = "plugins" },
  }
end

-- Setup lazy.nvim
require("lazy").setup({
  spec = plugin_spec,
  checker = { enabled = not is_file_chooser },
  change_detection = { enabled = not is_file_chooser },
  ui = { enabled = not is_file_chooser },
})

if is_file_chooser then
    require("file-chooser")
end

if vim.env.IS_LIGHT_THEME == "true" then
  vim.o.background = "light"
else
  vim.o.background = "dark"
end

if vim.env.NVIM_THEME then
  local status_ok, _ = pcall(vim.cmd.colorscheme, vim.env.NVIM_THEME)
  if not status_ok then
    print("Theme not found: " .. vim.env.NVIM_THEME)
  end
end
