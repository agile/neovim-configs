return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>f",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },

    -- Everything in opts will be passed to setup()
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            javascript = { { "prettierd", "prettier" } },
            lua = { "stylua" },
            -- python     = { "isort", "black" },
            -- sql        = {"sql_formatter" },
            sql = { "pg_format" },
            ["*"] = { "injected" },
        },

        -- Set up format-on-save
        -- format_on_save = function(bufnr)
        --     if vim.g.disable_autoformat or vim.b[bufnr].disable_autoforma then
        --         return
        --     end
        --     return { timeout_ms = 500, lsp_fallback = true }
        -- end,

        -- Customize formatters
        formatters = {
            shfmt = {
                prepend_args = { "-i", "2" },
            },
            yamlfix = {
                env = { YAMLFIX_WHITELINES = 1 },
            },
        },
    },

    init = function()
        -- If you want the formatexpr, here is the place to set it
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,

    config = function(_, opts)
        require("conform").setup(opts)

        -- local sqlcfg = vim.fn.expand("~/.config/sql_formatter.json")
        -- if vim.fn.filereadable(sqlcfg) then
        --   require("conform").formatters.sql_formatter = {
        --     prepend_args = { "-c", sqlcfg },
        --   }
        -- end

        local mdcfg = vim.fn.expand("~/.config/markdownlint.json")
        if vim.fn.filereadable(mdcfg) then
            require("conform").formatters.markdownlint = {
                prepend_args = { "-c", mdcfg },
            }
        end

        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                -- FormatDisable! will disable formatting just for this buffer
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
            desc = "Disable autoformat-on-save",
            bang = true,
        })
        vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = "Re-enable autoformat-on-save",
        })
    end,
}
