-- https://github.com/folke/tokyonight.nvim#%EF%B8%8F-configuration
local colorscheme = "tokyonight"
local theme_config = {style = "night"}

-- https://github.com/catppuccin/nvim
-- local colorscheme = "catppuccin"
vim.g.catppuccin_flavour = "mocha" -- latte (light theme), frappe, macchiato, mocha

-- Generally themes may have some configuration that can be tweaked and usually
-- need those tweaks made before the colorscheme is set below
require(colorscheme).setup(theme_config)

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
