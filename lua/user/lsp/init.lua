local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
    return
end

require("user.lsp.configs")
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"


-- local meson_ok, meson = pcall(require, "mason")
-- if not meson_ok then
--   return
-- end
-- require("mason").setup({
-- })
--
--
--
-- require("mason-lspconfig").setup({
--   ensure_installed = {
--     "sumneko_lua",
--   }
--   -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
--   -- This setting has no relation with the `ensure_installed` setting.
--   -- Can either be:
--   --   - false: Servers are not automatically installed.
--   --   - true: All servers set up via lspconfig are automatically installed.
--   --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
--   --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
--   automatic_installation = false,
-- })
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
