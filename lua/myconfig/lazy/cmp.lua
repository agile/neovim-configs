return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {                          -- nvim-cmp extensions
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
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      -- configure completetion to not auto-select suggestions
      preselect = "none", -- do not auto-select first item in list
      completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      },
      select_behavior = "select", -- insert: implicitly insert selection, select: NO IMPLICIT INSERTION

      sources = cmp.config.sources({
        { name = "path" },                    -- complete fs paths
        { name = "nvim_lsp" },                -- complete LSP suggestions
        { name = "buffer" },                  -- complete BUFFER suggestions
        { name = "luasnip" },                 -- complete LuaSnip suggestions
        { name = "cmp_jira" },                -- complete JIRA references
        { name = "plugins" },                 -- complete github refs for plugins
        { name = "nvim_lua" },                -- neovim lua api
        { name = "nvim_lsp_signature_help" }, -- display function signatures
      }),

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


      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-q>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({
          -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          select = false
        }),
        -- old config included maps for tab/s-tabing..
        -- I use tabs... some say you should stick to ins-completion but this is just here as an example
        ["<Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
        ["<S-Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
      }),

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
      },

      view = {
        entries = {
          name = "custom",
          selection_order = "near_cursor",
        },
      },

      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
        vim.notify
      },

      -- window = {
      --   completion = {
      --     winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      --     col_offset = -3,
      --     side_padding = 0,
      --   },
      -- },
    })
  end,
}
