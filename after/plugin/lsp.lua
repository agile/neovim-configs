local _lsp, lsp = pcall(require, "lsp-zero")
if not _lsp then
    return
end
local util = require("lspconfig.util")
local _lspformat, lspformat = pcall(require, "lsp-format")
if _lspformat then
    lspformat.setup({
        sync = true,
    })
end

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
    library = vim.api.nvim_get_runtime_file("", true),
})

-- Attempting to get terragrunt loved..
lsp.configure("terraform-ls", {
    root_dir = util.root_pattern(".terraform", ".terraform-version", ".git"),
    file_types = { "terraform", "terragrunt", "hcl" },
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end

    require("lsp-format").on_attach(client)

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

------------------------------
-- Completion Setup
------------------------------

-- see https://github.com/lttr/cmp-jira
local _cmp_jira, cmp_jira = pcall(require, "cmp_jira")
if _cmp_jira then
    cmp_jira.setup()
end

-- Additional completion sources
local cmp_sources = lsp.defaults.cmp_sources()
table.insert(cmp_sources, { name = "cmp_jira" }) -- complete JIRA references
table.insert(cmp_sources, { name = "plugins" }) -- complete gitup refs for plugins
table.insert(cmp_sources, { name = "nvim_lua" }) -- neovim lua api
table.insert(cmp_sources, { name = "nvim_lsp_signature_help" }) -- display function signatures

local _lspkind, lspkind = pcall(require, "lspkind")
local _devicons, devicons = pcall(require, "nvim-web-devicons")

local cmp_formatting = {}
if _lspkind and _devicons then
    -- TODO, maybe: https://github.com/onsails/lspkind.nvim/pull/30
    cmp_formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
            if vim.tbl_contains({ "path" }, entry.source.name) then
                local icon, hl_group = devicons.get_icon(entry:get_completion_item().label)
                if icon then
                    item.kind = icon
                    item.kind_hl_group = hl_group
                    return item
                end
            end

            local menu = {
                buffer = "[BUF]",
                cmp_jira = "[JIRA]",
                luasnip = "[SNIPPET]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[NVIM]",
                path = "[PATH]",
                plugins = "[PLUGIN]",
            }
            local kind_name = item.kind

            item = lspkind.cmp_format({
                -- use vscode icons
                -- preset = "codicons",
                preset = "default",
                mode = "symbol_text", -- symbol, symbol_text, text, text_symbol
                maxwidth = 100, -- truncate long entries
                ellipsis_char = "...", -- inidcator to append to truncated entries
                menu = menu,
            })(entry, item)

            -- could just yield item as lspkind formatted it but reformatting a little more to place the
            -- icon on the left of the suggestion..
            local strings = vim.split(item.kind, "%s", { trimempty = true })
            item.kind = " " .. strings[1] .. " "
            item.menu = " " .. (menu[entry.source.name] or "[???]") .. " (" .. kind_name .. ") "

            return item
        end,
    }
end

lsp.setup_nvim_cmp({
    -- configure completetion to not auto-select suggestions
    preselect = "none", -- do not auto-select first item in list
    completion = {
        completeopt = "menu,menuone,noinsert,noselect",
    },
    select_behavior = "select", -- insert: implicitly insert selection, select: NO IMPLICIT INSERTION

    sources = cmp_sources,
    window = {
        completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
        },
    },
    formatting = cmp_formatting,
})

lsp.setup()

------------------------------
-- POST LSP Zero Setup
------------------------------

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

        -- if null-ls is the source of truth
        automatic_setup = false,
        ensure_installed = nil,

        -- if mason-null-ls is the source of truth
        -- automatic_setup = true,
        -- ensure_installed = {
        --     "jq",
        --     "hadolint",
        --     "black",
        --     "isort",
        --     "pylint",
        --     "rubocop",
        --     "shellcheck",
        --     "stylelua",
        --     --"sql_formatter",
        -- },
    })
end

local _null_ls, null_ls = pcall(require, "null-ls")
if _null_ls then
    local sources = {
        -- docker
        null_ls.builtins.diagnostics.hadolint,
        -- json
        null_ls.builtins.formatting.jq,
        -- lua
        null_ls.builtins.formatting.stylua,
        -- packer
        null_ls.builtins.formatting.packer,
        -- python
        null_ls.builtins.formatting.black.with({
            extra_args = { "--line-length=120" },
        }),
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.pylint,
        -- R
        null_ls.builtins.formatting.format_r,
        -- ruby
        null_ls.builtins.diagnostics.rubocop,
        null_ls.builtins.formatting.rubocop,
        -- rust
        null_ls.builtins.formatting.rustfmt,
        -- scala
        null_ls.builtins.formatting.scalafmt,
        -- shell
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.hover.printenv,
        -- SQL
        null_ls.builtins.formatting.pg_format,
        -- terraform
        null_ls.builtins.formatting.terraform_fmt,

        -- etc..
        null_ls.builtins.diagnostics.trail_space,
    }

    null_ls.setup({ sources = sources })
end
