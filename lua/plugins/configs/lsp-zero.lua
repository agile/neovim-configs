local ok, lsp = pcall(require, "lsp-zero")
if not ok then
    return
end
local util = require "lspconfig.util"

lsp.preset("recommended")

lsp.ensure_installed({
    "awk_ls",
    "bashls",
    "clangd",
    "diagnosticls",
    "dockerls",
    "elixirls",
    "gopls",
    "html",
    "jsonls",
    "pyright",
    "ruby_ls",
    "rust_analyzer",
    -- "sqlls",
    -- "sqls",
    "sumneko_lua",
    "terraformls",
    "tflint",
    "yamlls",
})

lsp.configure("terraform-ls", {
    root_dir = util.root_pattern(".terraform", ".git", ".terraform-version"),
    file_types = {"terraform", "hcl"},
})

lsp.nvim_workspace()
lsp.setup()
