local _lsp, lsp = pcall(require, "lsp-zero")
if not _lsp then
    return
end
local util = require "lspconfig.util"

lsp.preset("recommended")

lsp.ensure_installed({
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

lsp.nvim_workspace({
  library = vim.api.nvim_get_runtime_file('', true)
})


-- local cmp = require("cmp")
-- local cmp_select = {behavior = cmp.SelectBehavior.Select}
-- local cmp_mappings = lsp.defaults.cmp_mappings({
--   ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
--   ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
--   ["<C-y>"] = cmp.mapping.confirm({ select = true }),
--   ["<C-Space>"] = cmp.mapping.complete(),
-- })
-- 
-- -- disable completion with tab
-- -- this helps with copilot setup
-- cmp_mappings["<Tab>"] = nil
-- cmp_mappings["<S-Tab>"] = nil
-- 
-- lsp.setup_nvim_cmp({
--   mapping = cmp_mappings
-- })
-- 
-- lsp.set_preferences({
--     suggest_lsp_servers = false,
--     sign_icons = {
--         error = "E",
--         warn = "W",
--         hint = "H",
--         info = "I"
--     }
-- })
lsp.configure("terraform-ls", {
    root_dir = util.root_pattern(".terraform", ".git", ".terraform-version"),
    file_types = {"terraform", "hcl"},
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, bufnr)
  end

  if client.name == "eslint" then
    vim.cmd.LspStop("eslint")
    return
  end

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
})

