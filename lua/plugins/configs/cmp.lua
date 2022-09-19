local _cmp, cmp = pcall(require, "cmp")
local _luasnip, luasnip = pcall(require, "luasnip")
local _lspkind, lspkind = pcall(require, "lspkind")

if not _cmp or not _lspkind then
    return
end

-- Lazy load all vscode like snippets
if _luasnip then
    require("luasnip/loaders/from_vscode").lazy_load()
end

-- https://github.com/KadoBOT/cmp-plugins
local _cmp_plugins, cmp_plugins = pcall(require, "cmp-plugins")
if _cmp_plugins then
  cmp_plugins.setup({
    -- files = {".*\\.lua"} -- default
    files = {  -- Recommended: use static filenames or partial paths
      "plugins.lua",
      "lua/plugins/",
    }
  })
end


local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

-- See https://github.com/hrsh7th/nvim-cmp/#setup

cmp.setup {
    preselect = cmp.PreselectMode.Item,
    -- completion = { autocomplete = false }, -- Make completion only on demand
    enabled = function()
        local in_prompt = vim.api.nvim_buf_get_option(0, "buftype") == "prompt"
        if in_prompt then
            return false
        end
        local context = require "cmp.config.context"
        return not (context.in_treesitter_capture "comment" == true or context.in_syntax_group "Comment")
    end,
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            -- cmp.config.compare.scopes,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            -- cmp.config.compare._under_comparator,
            require "cmp-under-comparator".under, -- https://github.com/lukas-reineke/cmp-under-comparator
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        }
    },
    formatting = {
        format = function(_, vim_item)
            -- Fancy icons and a name of kind
            vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
            return vim_item
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-q>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({
            select = true
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        -- old config included maps for tab/s-tabing..
    }),
    sources = {
        {name = "cmp_jira"},
        {name = "plugins"},
        {name = "nvim_lsp_signature_help"},
        {name = "nvim_lsp_documentation_help"},
        {name = "nvim_lsp"},
        {name = "nvim_lua"},
        {name = "luasnip"},
        {name = "path"},
        {name = "buffer", keyword_length=5},
        {name = "calc"},
        },
    }

cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{name = "buffer"}}
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline"}})
})

-- see https://github.com/lttr/cmp-jira
local _cmp_jira, cmp_jira = pcall(require, "cmp_jira")
if _cmp_jira then
  cmp_jira.setup()
end
