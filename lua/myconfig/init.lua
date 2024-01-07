require "myconfig.mappings"
require "myconfig.settings"

require "myconfig.lazy_init"

require "myconfig.globals"
require "myconfig.autocmds"

-- -- TODO: rewrite these in lua
vim.cmd "source ~/.config/nvim/mappings.vim"
vim.cmd "source ~/.config/nvim/youcaintspel.vim"
require "myconfig.settings"
