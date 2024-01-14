local lang_servers = {
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
    "pyright",       -- python
    "ruff_lsp",      -- extremely fast Python linter and code transformation
    "rust_analyzer", -- rust
    "sqls",          -- SQL
    "terraformls",   -- terraform hcl
    "tflint",        -- terraform lint
}
if vim.g.has_nix then
    -- nix language server
    vim.tbl_extend("force", lang_servers, { "nil_ls" })
end

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
        },
        config = function()
            local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
            local capabilities = require("cmp_nvim_lsp").default_capabilities(lsp_capabilities)
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = lang_servers,
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

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                update_in_insert = false,
                underline = true,
                severity_sort = false,
                float = true,
            })

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

                    -- if client.server_capabilities.completionProvider then
                    --     -- Enable completion triggered by <c-x><c-o>
                    --     vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
                    -- end

                    if client.server_capabilities.documentSymbolProvider then
                        require("nvim-navic").attach(client, bufnr)
                    end
                    require("lsp-format").on_attach(client)

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
}
