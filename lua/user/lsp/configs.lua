-- These are the servers that are managed by nvim-lsp-installer (or maybe soon, mason)
-- There maybe others that are managed manually outside this list.
local auto_installed_servers = {
  "bashls",
  "dockerls",
  "elixirls",
  "gopls",
  "jsonls",
  "pyright",
  "sqlls",
  "sqls",
  "sumneko_lua",
  "taplo", -- TOML
  "terraformls",
  -- "tflint",
  "yamlls",
}

local lsp_config_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_config_ok then
    return
end

local lsp_installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not lsp_installer_ok then
	return
end

-- lsp_installer does what you might expect: actually installs the LSP
-- :LspInstallInfo displays a menu of available and installed servers with their status and some
-- optional actions that can be performed such as un/install check for updates, update etc.
lsp_installer.setup({
	ensure_installed = auto_installed_servers,
  automatic_installation = true,
  ui = {
    icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
    }
  }
})

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
--   ensure_installed = auto_installed_servers
--
--   -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
--   -- This setting has no relation with the `ensure_installed` setting.
--   -- Can either be:
--   --   - false: Servers are not automatically installed.
--   --   - true: All servers set up via lspconfig are automatically installed.
--   --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
--   --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
--   automatic_installation = false,
-- })

-- Here we'll iterate through the above table of servers
for _, server in pairs(auto_installed_servers) do
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	lspconfig[server].setup(opts)
end

