local _impatient, impatient = pcall(require, "impatient")
if _impatient then
    impatient.enable_profile()
end

require "globals"
require "settings"
require "mappings"
require "plugins"
-- require "lsp"
require "autocmds"
require "commands"

-- TODO: rewrite these in lua
vim.cmd "source ~/.config/nvim/mappings.vim"
vim.cmd "source ~/.config/nvim/youcaintspel.vim"
