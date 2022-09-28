local _impatient, impatient = pcall(require, "impatient")
if _impatient then
    impatient.enable_profile()
end

local old_config = false

if old_config then
  require "user.options"
  require "user.keymaps"
  require "user.plugins"
  require "user.colorscheme"
  require "user.completions"
  require "user.lsp"
  require "user.autocmds"
  require "user.telescope"
  require "user.treesitter"
  require "user.autopairs"
  require "user.comments"
  require "user.gitsigns"
  require "user.nvim-tree"
  require "user.bufferline"
  require "user.fontzoom"
  require "user.lualine"
  require "user.toggleterm"
  require "user.impatient"
  require "user.indent-blankline"
  require "user.mini-trailspace"
  require "user.markdownpreview"

  -- TODO: rewrite these in lua
  vim.cmd "source ~/.config/nvim/mappings.vim"
else
  require "settings"
  require "mappings"
  require "plugins"
  require "lsp"
  require "autocmds"
  require "commands"
end
