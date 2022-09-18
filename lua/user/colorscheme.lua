-- https://github.com/NvChad/nvim-colorizer.lua
local colorizer_loaded_ok, colorizer = pcall(require, "colorizer")
if not colorizer_loaded_ok then
  return
end
colorizer.setup()

-- https://github.com/folke/tokyonight.nvim#%EF%B8%8F-configuration
local tokyonight_config = {
  style = "night",
  lualine_bold = true,
  -- sidebars = {
  --   "qf",
  --   "vista_kind",
  --   "terminal",
  --   "packer",
  --   "help",
  -- },
  -- see ~/.local/share/nvim/site/pack/packer/start/tokyonight.nvim/extras/lua_tokyonight_night.lua
  on_colors = function(colors)
    colors.hint = colors.purple
    -- colors.error = "#FF0000"
    colors.bg = "#060609" -- "#000000"
    colors.bg_dark = "#000000"
    colors.bg_sidebar = "#000000"
  end,
  on_highlights = function(hl, c)
    hl.Search = { bg = c.yellow, fg = c.black }
  end
}

local colorscheme = "tokyonight"
local theme_config = tokyonight_config

-- https://github.com/catppuccin/nvim
-- local colorscheme = "catppuccin"
-- local theme_config = {}
vim.g.catppuccin_flavour = "mocha" -- latte (light theme), frappe, macchiato, mocha

local loaded_ok, theme = pcall(require, colorscheme)
if not loaded_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

if next(theme_config) and theme.setup ~= nil then
  -- Generally themes may have some configuration that can be tweaked and usually
  -- need those tweaks made before the colorscheme is set below
  local setup_ok, _ = pcall(theme.setup, theme_config)
  if not setup_ok then
    vim.notify("colorscheme has no setup function")
    return
  end
end

local colorscheme_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not colorscheme_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
