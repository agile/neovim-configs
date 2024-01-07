require "mysetup.mappings"
require "mysetup.settings"

require "mysetup.lazy_init"

require "mysetup.globals"
require "mysetup.autocmds"

-- -- TODO: rewrite these in lua
vim.cmd "source ~/.config/nvim/mappings.vim"
vim.cmd "source ~/.config/nvim/youcaintspel.vim"
require "mysetup.settings"
