local colorscheme = "tokyonight"
-- local colorscheme = "catppuccin"

-- other settings documented here:
-- https://github.com/folke/tokyonight.nvim#%EF%B8%8F-configuration
vim.g.tokyonight_style = "night"  -- storm, night, or day
vim.g.boo_colorscheme_theme = "forest_stream" -- sunset_cloud, radioactive_waste, forest_stream, crimson_moonlight
-- https://github.com/catppuccin/nvim
vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
require("catppuccin").setup()

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
