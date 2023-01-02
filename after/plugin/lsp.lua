local _lsp, lsp = pcall(require, "lsp-zero")
if not _lsp then
    return
end
local util = require "lspconfig.util"

-- Turn down the noise
vim.lsp.set_log_level("WARN")

lsp.preset("recommended")

lsp.ensure_installed({
  "bashls",
  "clangd",
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

lsp.configure("terraform-ls", {
    root_dir = util.root_pattern(".terraform", ".terraform-version", ".git"),
    file_types = {"terraform", "terragrunt", "hcl"},
})

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

-- if you want to set up formatting on save, you can use this as a callback
local fmt_group = vim.api.nvim_create_augroup("LspFormatting", {})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, bufnr)
  end

  if client.supports_method("textDocument/formatting") then
    if client.name ~= "null-ls" then
      print("LSP client " .. client.name .. " supports formatting")
    end
      vim.api.nvim_clear_autocmds({ group = fmt_group, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
          group = fmt_group,
          buffer = bufnr,
          callback = function()
              lsp_formatting(bufnr)
          end,
      })
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

-- see https://github.com/lttr/cmp-jira
local _cmp_jira, cmp_jira = pcall(require, "cmp_jira")
if _cmp_jira then
  cmp_jira.setup()
end

-- Additional completion sources
local cmp_sources = lsp.defaults.cmp_sources()
table.insert(cmp_sources, {name = "cmp_jira"}) -- complete JIRA references
table.insert(cmp_sources, {name = "plugins"})  -- complete gitup refs for plugins
table.insert(cmp_sources, {name = "nvim_lua"}) -- neovim lua api
table.insert(cmp_sources, {name = "nvim_lsp_signature_help"}) -- display function signatures

local _lspkind, lspkind = pcall(require, "lspkind")
local _devicons, devicons = pcall(require, "nvim-web-devicons")
local cmp_formatting = {}
if _lspkind and _devicons then
  -- TODO: https://github.com/onsails/lspkind.nvim/pull/30
  cmp_formatting = {
    -- fields = {"menu", "abbr", "kind"},
    format = function(entry, item)
      if vim.tbl_contains({"path"}, entry.source.name) then
        local icon, hl_group = devicons.get_icon(entry:get_completion_item().label)
        if icon then
          item.kind = icon
          item.kind_hl_group = hl_group
          return item
        end
      end
      return lspkind.cmp_format({
        mode = "symbol_text",       -- symbol, symbol_text, text, text_symbol
        maxwidth = 50,         -- truncate long entries
        ellipsis_char = "...", -- inidcator to append to truncated entries
        -- with_text = true
      })(entry, item)
    end,
  }
end

lsp.setup_nvim_cmp({
  -- configure completetion to not auto-select suggestions
  preselect = "none",  -- do not auto-select first item in list
  completion = {
    completeopt = "menu,menuone,noinsert,noselect",
  },
  select_behavior = "select", -- insert: implicitly insert selection, select: NO IMPLICIT INSERTION

  sources = cmp_sources,
  formatting = cmp_formatting,
})

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})

-- Initialize Mason/null-ls, needs to be done after lsp.setup()
-- https://github.com/VonHeikemen/lsp-zero.nvim/issues/60#issuecomment-1363800412
local _mason_nls, mason_nls = pcall(require, "mason-null-ls")
if _mason_nls then
  mason_nls.setup({
    automatic_installation = true,
    automatic_setup = true,
    ensure_installed = {
      "stylua",
      "jq",
      "hadolint",
      "black",
      "pylint",
      "shellcheck",
      --"sql_formatter",
    },
  })
end


local _null_ls, null_ls = pcall(require, "null-ls")
if _null_ls then
  local sources = {
    -- python
    null_ls.builtins.formatting.black.with({
      extra_args = { "--line-length=120" }
    }),
    null_ls.builtins.formatting.isort,
  }

  null_ls.setup({ sources = sources })
end


-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
end
