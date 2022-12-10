local M = {}
local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
local signature_cfg = {
	bind = true, -- This is mandatory, otherwise border config won't get registered.
	-- If you want to hook lspsaga or other signature handler, pls set to false
	doc_lines = 2, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
	-- set to 0 if you DO NOT want any API comments be shown
	-- This setting only take effect in insert mode, it does not affect signature help in normal
	-- mode, 10 by default

	floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
	hint_enable = true, -- virtual hint enable
	hint_prefix = "🐼 ", -- Panda for parameter
	hint_scheme = "String",
	use_lspsaga = false, -- set to true if you want to use lspsaga popup
	hi_parameter = "Search", -- how your parameter will be highlight
	max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
	-- to view the hiding contents
	max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
	handler_opts = {
		border = "single", -- double, single, shadow, none
	},
	-- deprecate !!
	-- decorator = {"`", "`"}  -- this is no longer needed as nvim give me a handler and it allow me to highlight active parameter in floating_window
}

local function set_document_higlighting(client)
  if client.server_capabilities.documentFormattingProvider then
    require("illuminate").on_attach(client)
  end
end

local function set_signature_helper(client, bufnr)
  if client.server_capabilities.signatureHelpProvider then
    require("lsp_signature").on_attach(signature_cfg, bufnr)
  end
end

local function set_hover_border(client)
  if client.server_capabilities.hoverProvider then
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
            -- border = border,
            border = "single",
        }
    )
  end
end

local function get_basic_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  return capabilities
end

local function attach_navic(client, bufnr)
    local have_navic, navic = pcall(require, 'navim-navic')
    if not have_navic then
        return
    end
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
end

local function attach_aerial(client, bufnr)
    local have_aerial, aerial = pcall(require, 'aerial')
    if not have_aerial then
        return
    end
    aerial.on_attach(client, bufnr)
end

M.on_attach = function(client, bufnr)
    set_document_higlighting(client)
    set_signature_helper(client, bufnr)
    set_hover_border(client)
    attach_aerial(client, bufnr)
    attach_navic(client, bufnr)
  end

M.capabilities = require("cmp_nvim_lsp").default_capabilities(get_basic_capabilities())

return M
