
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local codeicons_ok, codeicons = pcall(require, "codeicons")
if codeicons_ok then
  codeicons.setup()
end

local lspkind_ok, lspkind = pcall(require, "lspkind")
if not lspkind_ok then
  return
end

lspkind.init({
  -- defines how annotations are shown
  -- default: symbol
  -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
  mode = "symbol_text",

  -- default symbol map
  -- can be either 'default' (requires nerd-fonts font) or
  -- 'codicons' for codicon preset (requires vscode-codicons font)
  --
  -- default: 'default'
  preset = 'codicons',

  -- override preset symbols
  --
  -- default: {}
  -- symbol_map = {
  --   Text = "",
  --   Method = "",
  --   Function = "",
  --   Constructor = "",
  --   Field = "ﰠ",
  --   Variable = "",
  --   Class = "ﴯ",
  --   Interface = "",
  --   Module = "",
  --   Property = "ﰠ",
  --   Unit = "塞",
  --   Value = "",
  --   Enum = "",
  --   Keyword = "",
  --   Snippet = "",
  --   Color = "",
  --   File = "",
  --   Reference = "",
  --   Folder = "",
  --   EnumMember = "",
  --   Constant = "",
  --   Struct = "פּ",
  --   Event = "",
  --   Operator = "",
  --   TypeParameter = ""
  -- },
})

--   פּ ﯟ   some other good icons
-- local kind_icons = {
--   Text = "",
--   Method = "m",
--   Function = "",
--   Constructor = "",
--   Field = "",
--   Variable = "",
--   Class = "",
--   Interface = "",
--   Module = "",
--   Property = "",
--   Unit = "",
--   Value = "",
--   Enum = "",
--   Keyword = "",
--   Snippet = "",
--   Color = "",
--   File = "",
--   Reference = "",
--   Folder = "",
--   EnumMember = "",
--   Constant = "",
--   Struct = "",
--   Event = "",
--   Operator = "",
--   TypeParameter = "",
-- }
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol", -- show only symbol annotations
      maxwidth = 50, -- prevent popup from showing more than provided chars
      menu = {
        buffer = "[Buffer]",
        calc = "[CALC]",
        cmp_jira = "[JIRA]",
        luasnip = "[Snippet]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[LUA]",
        path = "[Path]",
        plugins = "[PLUGIN]",
      },
      before = function(entry, vim_item)
        -- re: https://github.com/onsails/lspkind.nvim/pull/30
        -- local word = entry.get_insert_text()
        -- if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
        --   word = vim.lsp.util.parse_snippet(word)
        -- end
        -- word = str.oneline(word)
        -- if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
        --   word = word .. "~"
        -- end
        -- vim_item.abbr = word
        return vim_item
      end
    })
    -- fields = { "kind", "abbr", "menu" },
    -- format = function(entry, vim_item)
    --   -- Kind icons
    --   vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
    --   -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
    --   vim_item.menu = ({
    --     cmp_jira = "[JIRA]",
    --     plugins = "[PLUGIN]",
    --     nvim_lua = "[LUA]",
    --     luasnip = "[Snippet]",
    --     buffer = "[Buffer]",
    --     path = "[Path]",
    --     calc = "[CALC]",
    --   })[entry.source.name]
    --   return vim_item
    -- end,
  },
  sources = {
    { name = "cmp_jira" },
    { name = "nvim_lsp" },
    { name = "plugins" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "calc" },
    { name = "buffer", keyword_length = 5 },
    { name = "path" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = cmp.config.window.bordered {
      "╭", "─", "╮", "│", "╯", "─", "╰", "│"
    },
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
}
