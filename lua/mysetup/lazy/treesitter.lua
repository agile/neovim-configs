return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
      "p00f/nvim-ts-rainbow",                        -- Open/Close node coloring
      "nvim-treesitter/nvim-treesitter-textobjects", -- identify comments
      "JoosepAlviste/nvim-ts-context-commentstring", -- commentstring
      "phelipetls/jsonpath.nvim",                    -- Show jq like path in json under cursor
      -- "the-mikedavis/tree-sitter-diff",            -- grammar for diff output
  },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      -- A list of parser names, or "all"
      -- ensure_installed = { "help", "javascript", "typescript", "c", "lua", "rust" },
      -- ensure_installed = "all",
      -- list of parsers to ignore installing when ensure is configured as "all"
      -- ignore_install = {},

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = '<c-s>',
          node_decremental = '<c-backspace>',
        },
      },
    })

    vim.api.nvim_set_hl(0, "@text.diff.add", { link = "DiffAdd" })
    vim.api.nvim_set_hl(0, "@text.diff.delete", { link = "DiffDelete" })
  end
}
