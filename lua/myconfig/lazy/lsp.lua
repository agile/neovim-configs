return {
    -- Rust LSP extensions
    {
        "simrat39/rust-tools.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    -- Scala LSP extensions
    {
        "scalameta/nvim-metals",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "mfussenegger/nvim-dap",
        },
    },
    -- R-lang
    {
        "jalvesaq/Nvim-R",
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "lukas-reineke/lsp-format.nvim",
            "SmiteshP/nvim-navic",
            {
                "hrsh7th/nvim-cmp",
                event = { "InsertEnter", "CmdlineEnter" },
            },
            -- {                                           -- nvim-cmp extensions
            "onsails/lspkind.nvim",                 -- VSCode like item type icons
            "kyazdani42/nvim-web-devicons",         -- MOAR ICONS
            "hrsh7th/cmp-buffer",                   -- Buffer completions
            "hrsh7th/cmp-calc",                     -- Math completions
            "hrsh7th/cmp-cmdline",                  -- Command line completions
            "hrsh7th/cmp-nvim-lsp",                 -- LSP completions
            "hrsh7th/cmp-nvim-lsp-document-symbol", -- LSP textDocument/documentSymbol completions
            "hrsh7th/cmp-nvim-lsp-signature-help",  -- LSP Signature completions
            "hrsh7th/cmp-nvim-lua",                 -- Lua completions
            "hrsh7th/cmp-path",                     -- Path completions
            "lukas-reineke/cmp-under-comparator",   -- Better sort completion items starting with underscore (Python)
            "lttr/cmp-jira",                        -- JIRA completions
            "KadoBOT/cmp-plugins",                  -- Neovim plugin completions
            "saadparwaiz1/cmp_luasnip",             -- Snippet completions
            -- },
        },
        config = function()
            local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
            local capabilities = require("cmp_nvim_lsp").default_capabilities(lsp_capabilities)
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls",        -- bash
                    "clangd",        -- c/c++
                    "cmake",         -- cmake language server
                    "cssls",         -- css language server
                    "dockerls",      -- dockerfile
                    "elixirls",      -- elixir
                    "gopls",         -- go
                    "html",          -- html language server
                    "jdtls",         -- java
                    "jsonnet_ls",    -- jsonnet language server
                    "lua_ls",        -- lua
                    "nil_ls",        -- nix language server
                    "pyright",       -- python
                    "ruff_lsp",      -- extremely fast Python linter and code transformation
                    "rust_analyzer", -- rust
                    "sqls",          -- SQL
                    "terraformls",   -- terraform hcl
                    "tflint",        -- terraform lint
                },
                handlers = {
                    -- The first entry (without a key) will be the default handler
                    -- and will be called for each installed server that doesn't have
                    -- a dedicated handler.
                    function(server_name) -- default handler (optional)
                        require("lspconfig")[server_name].setup({
                            capabilties = capabilities
                        })
                    end,
                    -- Next, you can provide targeted overrides for specific servers.
                    ["rust_analyzer"] = function()
                        require("rust-tools").setup({
                            capabilties = capabilities
                        })
                    end,
                    ["lua_ls"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.lua_ls.setup {
                            capabilties = capabilities,
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim" }
                                    }
                                }
                            }
                        }
                    end,
                },
            })

            local cmp = require("cmp")
            cmp.setup({
                -- configure completetion to not auto-select suggestions
                preselect = "none", -- do not auto-select first item in list
                completion = {
                    completeopt = "menu,menuone,noinsert,noselect",
                },
                select_behavior = "select",               -- insert: implicitly insert selection, select: NO IMPLICIT INSERTION
                sources = cmp.config.sources({
                    { name = "path" },                    -- complete fs paths
                    { name = "nvim_lsp" },                -- complete JIRA references
                    { name = "buffer" },                  -- complete JIRA references
                    { name = "luasnip" },                 -- complete JIRA references

                    { name = "cmp_jira" },                -- complete JIRA references
                    { name = "plugins" },                 -- complete gitup refs for plugins
                    { name = "nvim_lua" },                -- neovim lua api
                    { name = "nvim_lsp_signature_help" }, -- display function signatures
                }),
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

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
            -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    if client.server_capabilities.completionProvider then
                        -- Enable completion triggered by <c-x><c-o>
                        vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
                    end

                    if client.server_capabilities.documentSymbolProvider then
                        require("nvim-navic").attach(client, bufnr)
                    end

                    vim.g.diagnostics_visible = true
                    local function toggle_diagnostics()
                        if vim.g.diagnostics_visible then
                            vim.g.diagnostics_visible = false
                            vim.diagnostic.disable()
                        else
                            vim.g.diagnostics_visible = true
                            vim.diagnostic.enable()
                        end
                    end

                    require("lsp-format").on_attach(client)

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = args.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    -- vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set("n", "<leader>D", toggle_diagnostics,
                        vim.tbl_extend("force", opts, { desc = "lsp toggle diagnostics" }))
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<leader>f', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
                end,
            })
        end,
    },

    -- TODO
    -- -- LSP
    -- use({
    --     "VonHeikemen/lsp-zero.nvim",
    --     requires = {
    --         -- LSP Support
    --         { "neovim/nvim-lspconfig" },
    --         { "jose-elias-alvarez/null-ls.nvim" },
    --         { "williamboman/mason.nvim" },
    --         { "williamboman/mason-lspconfig.nvim" },
    --         { "jay-babu/mason-null-ls.nvim" },

    --         -- Formatting config helper
    --         { "lukas-reineke/lsp-format.nvim" },

    --         -- Autocompletion
    --         { "hrsh7th/nvim-cmp" },

    --         {                                           -- nvim-cmp extensions
    --             "onsails/lspkind.nvim",                 -- VSCode like item type icons
    --             "kyazdani42/nvim-web-devicons",         -- MOAR ICONS
    --             "hrsh7th/cmp-buffer",                   -- Buffer completions
    --             "hrsh7th/cmp-calc",                     -- Math completions
    --             "hrsh7th/cmp-cmdline",                  -- Command line completions
    --             "hrsh7th/cmp-nvim-lsp",                 -- LSP completions
    --             "hrsh7th/cmp-nvim-lsp-document-symbol", -- LSP textDocument/documentSymbol completions
    --             "hrsh7th/cmp-nvim-lsp-signature-help",  -- LSP Signature completions
    --             "hrsh7th/cmp-nvim-lua",                 -- Lua completions
    --             "hrsh7th/cmp-path",                     -- Path completions
    --             "lukas-reineke/cmp-under-comparator",   -- Better sort completion items starting with underscore (Python)
    --             "lttr/cmp-jira",                        -- JIRA completions
    --             "KadoBOT/cmp-plugins",                  -- Neovim plugin completions
    --             "saadparwaiz1/cmp_luasnip",             -- Snippet completions
    --         },

    --         -- Snippets
    --         { "L3MON4D3/LuaSnip" },
    --         { "rafamadriz/friendly-snippets" },
    --     },
    -- })

    -- LSP ZERO CONFIG/SETUP
    -- local _lsp, lsp = pcall(require, "lsp-zero")
    -- if not _lsp then
    --     return
    -- end
    -- local util = require("lspconfig.util")
    -- local _lspformat, lspformat = pcall(require, "lsp-format")
    -- if _lspformat then
    --     lspformat.setup({
    --         sync = true,
    --     })
    -- end
    --
    -- -- Turn down the noise
    -- vim.lsp.set_log_level("WARN")
    --
    -- lsp.preset("recommended")
    --
    -- lsp.ensure_installed({
    --     "bashls",
    --     "clangd",
    --     "dockerls",
    --     "elixirls",
    --     "gopls",
    --     "html",
    --     "jsonls",
    --     "pyright",
    --     -- "ruby_ls",
    --     "rust_analyzer",
    --     -- "sqlls",
    --     -- "sqls",
    --     "lua_ls",
    --     "terraformls",
    --     "tflint",
    --     "yamlls",
    -- })
    --
    -- lsp.nvim_workspace({
    --     library = vim.api.nvim_get_runtime_file("", true),
    -- })
    --
    -- -- Attempting to get terragrunt loved..
    -- lsp.configure("terraform-ls", {
    --     root_dir = util.root_pattern(".terraform", ".terraform-version", ".git"),
    --     file_types = { "terraform", "terragrunt", "hcl" },
    -- })
    --
    -- lsp.on_attach(function(client, bufnr)
    --     local opts = { buffer = bufnr, remap = false }
    --
    --     if client.server_capabilities.documentSymbolProvider then
    --         require("nvim-navic").attach(client, bufnr)
    --     end
    --
    --     vim.g.diagnostics_visible = true
    --     local function toggle_diagnostics()
    --         if vim.g.diagnostics_visible then
    --             vim.g.diagnostics_visible = false
    --             vim.diagnostic.disable()
    --         else
    --             vim.g.diagnostics_visible = true
    --             vim.diagnostic.enable()
    --         end
    --     end
    --
    --     require("lsp-format").on_attach(client)
    --
    --     vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    --     vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
    --     vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    --     vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    --     vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    --     vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
    --     vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    --
    --     vim.keymap.set("n", "<leader>D", toggle_diagnostics,
    --         vim.tbl_extend("force", opts, { desc = "lsp toggle diagnostics" }))
    --     vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    --     vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    --     vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    --     vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    --     vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    --     vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    --     vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    --
    --     vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    -- end)
    --
    -- ------------------------------
    -- -- Completion Setup
    -- ------------------------------
    --
    -- -- see https://github.com/lttr/cmp-jira
    -- local _cmp_jira, cmp_jira = pcall(require, "cmp_jira")
    -- if _cmp_jira then
    --     cmp_jira.setup()
    -- end
    --
    -- -- Additional completion sources
    -- local cmp_sources = lsp.defaults.cmp_sources()                  -- path, nvim_lsp, buffer, luasnip
    -- table.insert(cmp_sources, { name = "cmp_jira" })                -- complete JIRA references
    -- table.insert(cmp_sources, { name = "plugins" })                 -- complete gitup refs for plugins
    -- table.insert(cmp_sources, { name = "nvim_lua" })                -- neovim lua api
    -- table.insert(cmp_sources, { name = "nvim_lsp_signature_help" }) -- display function signatures
    --
    -- lsp.setup_nvim_cmp({
    --     -- configure completetion to not auto-select suggestions
    --     preselect = "none", -- do not auto-select first item in list
    --     completion = {
    --         completeopt = "menu,menuone,noinsert,noselect",
    --     },
    --     select_behavior = "select", -- insert: implicitly insert selection, select: NO IMPLICIT INSERTION
    --     sources = cmp_sources,
    --     window = {
    --         completion = {
    --             winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
    --             col_offset = -3,
    --             side_padding = 0,
    --         },
    --     },
    --     formatting = {
    --         -- TODO, maybe.. Better formatting of snippet suggestions
    --         -- https://github.com/onsails/lspkind.nvim/pull/30
    --         -- https://github.com/danymat/dotfiles/blob/d91534d08e5a3f6085f8348ec3c41982e9b74941/nvim/.config/nvim/lua/configs/cmp.lua#L35-L59
    --         fields = { "kind", "abbr", "menu" },
    --         format = function(entry, item)
    --             if vim.tbl_contains({ "path" }, entry.source.name) then
    --                 local devicons = require("nvim-web-devicons")
    --                 local icon, hl_group = devicons.get_icon(entry:get_completion_item().label)
    --                 if icon then
    --                     item.kind = icon
    --                     item.kind_hl_group = hl_group
    --                     return item
    --                 end
    --             end
    --
    --             local menu = {
    --                 buffer = "[BUF]",
    --                 cmp_jira = "[JIRA]",
    --                 luasnip = "[SNIPPET]",
    --                 nvim_lsp = "[LSP]",
    --                 nvim_lua = "[NVIM]",
    --                 path = "[PATH]",
    --                 plugins = "[PLUGIN]",
    --             }
    --             local kind_name = item.kind
    --
    --             item = require("lspkind").cmp_format({
    --                 -- use vscode icons
    --                 -- preset = "codicons",
    --                 preset = "default",
    --                 mode = "symbol_text",  -- symbol, symbol_text, text, text_symbol
    --                 maxwidth = 100,        -- truncate long entries
    --                 ellipsis_char = "...", -- inidcator to append to truncated entries
    --                 menu = menu,
    --             })(entry, item)
    --
    --             -- could just yield item as lspkind formatted it but reformatting a little more to place the
    --             -- icon on the left of the suggestion..
    --             local strings = vim.split(item.kind, "%s", { trimempty = true })
    --             item.kind = " " .. strings[1] .. " "
    --             item.menu = " " .. (menu[entry.source.name] or "[???]") .. " (" .. kind_name .. ") "
    --
    --             return item
    --         end,
    --     }
    -- })
    --
    -- lsp.setup()
    --
    -- ------------------------------
    -- -- POST LSP Zero Setup
    -- ------------------------------
    --
    -- vim.diagnostic.config({
    --     virtual_text = true,
    --     signs = true,
    --     update_in_insert = false,
    --     underline = true,
    --     severity_sort = false,
    --     float = true,
    -- })
    --
    -- -- Initialize Mason/null-ls, needs to be done after lsp.setup()
    -- -- https://github.com/VonHeikemen/lsp-zero.nvim/issues/60#issuecomment-1363800412
    -- local _mason_nls, mason_nls = pcall(require, "mason-null-ls")
    -- if _mason_nls then
    --     mason_nls.setup({
    --         automatic_installation = true,
    --         -- if null-ls is the source of truth
    --         automatic_setup = false,
    --         ensure_installed = {
    --             "hadolint",
    --             "goimports",
    --             "goimports_reviser",
    --             "golangci_lint",
    --             "golines",
    --             "prettier",
    --             "jq",
    --             "stylua",
    --             -- Found it is actually more ideal to have these managed by venvs
    --             --"black",
    --             --"isort",
    --             --"pylint",
    --             -- "rubocop",
    --             "shellcheck",
    --         },
    --         -- if mason-null-ls is the source of truth
    --         -- automatic_setup = true,
    --     })
    -- end
    --
    -- local _null_ls, null_ls = pcall(require, "null-ls")
    -- if _null_ls then
    --     local function exists(bin)
    --         return vim.fn.exepath(bin) ~= ""
    --     end
    --
    --     local sources = {
    --         -- docker
    --         null_ls.builtins.diagnostics.hadolint,
    --         -- go
    --         null_ls.builtins.code_actions.gomodifytags,
    --         null_ls.builtins.diagnostics.golangci_lint,
    --         null_ls.builtins.formatting.gofmt,
    --         null_ls.builtins.formatting.goimports,
    --         null_ls.builtins.formatting.goimports_reviser,
    --         null_ls.builtins.formatting.golines,
    --         -- json (prettier handles json too)
    --         -- null_ls.builtins.formatting.jq,
    --         -- lua
    --         null_ls.builtins.formatting.stylua,
    --         -- markdown
    --         null_ls.builtins.formatting.markdown_toc,
    --         -- packer
    --         null_ls.builtins.formatting.packer,
    --         -- R
    --         null_ls.builtins.formatting.format_r,
    --         -- rust
    --         null_ls.builtins.formatting.rustfmt,
    --         -- scala
    --         null_ls.builtins.formatting.scalafmt,
    --         -- shell
    --         null_ls.builtins.code_actions.shellcheck,
    --         null_ls.builtins.diagnostics.shellcheck,
    --         null_ls.builtins.hover.printenv,
    --         -- SQL
    --         null_ls.builtins.formatting.pg_format,
    --         -- null_ls.builtins.formatting.sql_formatter,
    --         -- null_ls.builtins.formatting.sqlfluff,
    --         -- null_ls.builtins.formatting.sqlformat,
    --         -- terraform
    --         null_ls.builtins.formatting.terraform_fmt,
    --         -- yaml
    --         -- null_ls.builtins.diagnostics.yamllint,
    --         -- null_ls.builtins.diagnostics.yamlfmt, (prettier formats yaml too)
    --
    --         -- etc..
    --         null_ls.builtins.formatting.prettier,
    --         null_ls.builtins.code_actions.refactoring,
    --         null_ls.builtins.completion.luasnip,
    --         null_ls.builtins.diagnostics.trail_space,
    --         null_ls.builtins.completion.spell.with({
    --             -- filetypes = {"markdown", "html", "text"},
    --         }),
    --     }
    --
    --     --
    --     -- if exists("selene") then
    --     --     table.insert(sources, null_ls.builtins.diagnostics.selene)
    --     -- end
    --     -- python
    --     if exists("black") then
    --         table.insert(sources,
    --             null_ls.builtins.formatting.black.with({
    --                 extra_args = { "--line-length=120" },
    --                 prefer_local = true,
    --             }))
    --     end
    --     if exists("isort") then
    --         table.insert(sources,
    --             null_ls.builtins.formatting.isort.with({
    --                 prefer_local = true,
    --             }))
    --     end
    --     -- if exists("pylint") then
    --     --     table.insert(sources,
    --     --         null_ls.builtins.diagnostics.pylint.with({
    --     --             prefer_local = true,
    --     --             --
    --     --             diagnostics_postprocess = function(diagnostic)
    --     --                 diagnostic.code = diagnostic.message_id
    --     --             end,
    --     --         }))
    --     -- end
    --     if exists("mypy") then
    --         table.insert(sources, null_ls.builtins.diagnostics.mypy)
    --     end
    --     -- ruby
    --     if exists("rubocop") then
    --         table.insert(sources,
    --             null_ls.builtins.diagnostics.rubocop.with({
    --                 prefer_local = true,
    --             }))
    --         table.insert(sources,
    --             null_ls.builtins.formatting.rubocop.with({
    --                 prefer_local = true,
    --             }))
    --     end
    --
    --     null_ls.setup({ sources = sources })
    -- end


    -- METALS Config/Setup
    -- local _metals_ok, metals = pcall(require, "metals")
    -- if not _metals_ok then
    --   vim.notify("Failed to load metals", "error")
    --   return
    -- end
    --
    -- ----------------------------------
    -- -- LSP Setup ---------------------
    -- ----------------------------------
    -- local metals_config = metals.bare_config()
    --
    -- -- Example of settings
    -- metals_config.settings = {
    --   showImplicitArguments = true,
    --   excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
    -- }
    --
    -- -- *READ THIS*
    -- -- I *highly* recommend setting statusBarProvider to true, however if you do,
    -- -- you *have* to have a setting to display this in your statusline or else
    -- -- you'll not see any messages from metals. There is more info in the help
    -- -- docs about this
    -- metals_config.init_options.statusBarProvider = "on"
    --
    -- -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    --
    -- -- Debug settings if you're using nvim-dap
    -- local _dap_ok, dap = pcall(require, "dap")
    -- if _dap_ok then
    --   dap.configurations.scala = {
    --     {
    --       type = "scala",
    --       request = "launch",
    --       name = "RunOrTest",
    --       metals = {
    --         runType = "runOrTestFile",
    --         --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
    --       },
    --     },
    --     {
    --       type = "scala",
    --       request = "launch",
    --       name = "Test Target",
    --       metals = {
    --         runType = "testTarget",
    --       },
    --     },
    --   }
    --
    --   metals_config.on_attach = function(client, _bufnr)
    --     metals.setup_dap()
    --   end
    -- end
    --
    -- -- Autocmd that will actually be in charging of starting the whole thing
    -- local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    -- vim.api.nvim_create_autocmd("FileType", {
    --   -- NOTE: You may or may not want java included here. You will need it if you
    --   -- want basic Java support but it may also conflict if you are using
    --   -- something like nvim-jdtls which also works on a java filetype autocmd.
    --   pattern = { "scala", "sbt", "sc" },
    --   callback = function()
    --     require("metals").initialize_or_attach(metals_config)
    --   end,
    --   group = nvim_metals_group,
    -- })
}
