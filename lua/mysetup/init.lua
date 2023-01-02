--, {desc = ""}- local _impatient, impatient = pcall(require, "impatient")
-- if _impatient then
--     impatient.enable_profile()
-- end

require "mysetup.globals"
require "mysetup.settings"
require "mysetup.mappings"
require "mysetup.autocmds"

-- require "mysetup.plugins"
-- -- require "lsp"

-- -- TODO: rewrite these in lua
vim.cmd "source ~/.config/nvim/mappings.vim"
vim.cmd "source ~/.config/nvim/youcaintspel.vim"
