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
    -- "ruby_ls",
    "rust_analyzer",
    -- "sqlls",
    -- "sqls",
    "lua_ls",
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

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

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
local cmp_sources = lsp.defaults.cmp_sources()                  -- path, nvim_lsp, buffer, luasnip
table.insert(cmp_sources, { name = "cmp_jira" })                -- complete JIRA references
table.insert(cmp_sources, { name = "plugins" })                 -- complete gitup refs for plugins
table.insert(cmp_sources, { name = "nvim_lua" })                -- neovim lua api
table.insert(cmp_sources, { name = "nvim_lsp_signature_help" }) -- display function signatures

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
    formatting = {
        -- TODO, maybe.. Better formatting of snippet suggestions
        -- https://github.com/onsails/lspkind.nvim/pull/30
        -- https://github.com/danymat/dotfiles/blob/d91534d08e5a3f6085f8348ec3c41982e9b74941/nvim/.config/nvim/lua/configs/cmp.lua#L35-L59
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
            if vim.tbl_contains({ "path" }, entry.source.name) then
                local devicons = require("nvim-web-devicons")
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

            item = require("lspkind").cmp_format({
                -- use vscode icons
                -- preset = "codicons",
                preset = "default",
                mode = "symbol_text",  -- symbol, symbol_text, text, text_symbol
                maxwidth = 100,        -- truncate long entries
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
        ensure_installed = {
            "hadolint",
            "goimports",
            "goimports_reviser",
            "golangci_lint",
            "golines",
            "prettier",
            "jq",
            "stylua",
            -- Found it is actually more ideal to have these managed by venvs
            --"black",
            --"isort",
            --"pylint",
            -- "rubocop",
            "shellcheck",
        },
        -- if mason-null-ls is the source of truth
        -- automatic_setup = true,
    })
end

local _null_ls, null_ls = pcall(require, "null-ls")
if _null_ls then
    local function exists(bin)
        return vim.fn.exepath(bin) ~= ""
    end

    local sources = {
        -- docker
        null_ls.builtins.diagnostics.hadolint,
        -- go
        null_ls.builtins.code_actions.gomodifytags,
        null_ls.builtins.diagnostics.golangci_lint,
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.goimports_reviser,
        null_ls.builtins.formatting.golines,
        -- json (prettier handles json too)
        -- null_ls.builtins.formatting.jq,
        -- lua
        null_ls.builtins.formatting.stylua,
        -- markdown
        null_ls.builtins.formatting.markdown_toc,
        -- packer
        null_ls.builtins.formatting.packer,
        -- R
        null_ls.builtins.formatting.format_r,
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
        -- null_ls.builtins.formatting.sql_formatter,
        -- null_ls.builtins.formatting.sqlfluff,
        -- null_ls.builtins.formatting.sqlformat,
        -- terraform
        null_ls.builtins.formatting.terraform_fmt,
        -- yaml
        null_ls.builtins.diagnostics.yamllint,
        -- null_ls.builtins.diagnostics.yamlfmt, (prettier formats yaml too)

        -- etc..
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.completion.luasnip,
        null_ls.builtins.diagnostics.trail_space,
        null_ls.builtins.completion.spell.with({
            -- filetypes = {"markdown", "html", "text"},
        }),
    }

    --
    -- if exists("selene") then
    --     table.insert(sources, null_ls.builtins.diagnostics.selene)
    -- end
    -- python
    if exists("black") then
        table.insert(sources,
            null_ls.builtins.formatting.black.with({
                extra_args = { "--line-length=120" },
                prefer_local = true,
            }))
    end
    if exists("isort") then
        table.insert(sources,
            null_ls.builtins.formatting.isort.with({
                prefer_local = true,
            }))
    end
    if exists("pylint") then
        table.insert(sources,
            null_ls.builtins.diagnostics.pylint.with({
                prefer_local = true,
            }))
    end
    if exists("mypy") then
        table.insert(sources, null_ls.builtins.diagnostics.mypy)
    end
    -- ruby
    if exists("rubocop") then
        table.insert(sources,
            null_ls.builtins.diagnostics.rubocop.with({
                prefer_local = true,
            }))
        table.insert(sources,
            null_ls.builtins.formatting.rubocop.with({
                prefer_local = true,
            }))
    end

    null_ls.setup({ sources = sources })
end
