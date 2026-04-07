local separator_left = os.getenv("SEPARATOR_LEFT") or ""
local separator_right = os.getenv("SEPARATOR_RIGHT") or ""
local separator_left_thin = os.getenv("SEPARATOR_LEFT_THIN") or ""
local separator_right_thin = os.getenv("SEPARATOR_RIGHT_THIN") or ""

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        component_separators = { left = separator_left_thin, right = separator_right_thin },
        section_separators = { left = separator_left, right = separator_right },
      },
    }
  end
}
