require("user.lsp.configs")           -- where LSP servers are configured, sometimes installed
require("user.lsp.handlers").setup()  -- generalized on_attach/capabilities/keymaps
require "user.lsp.null-ls"            -- formatters/linters

-- TODO
-- https://www.reddit.com/r/neovim/comments/w5h9tl/lsp_linesnvim_v2_is_out/
-- ^ show LSP diagnostics via virtual lines (github mirror: https://github.com/Maan2003/lsp_lines.nvim)
