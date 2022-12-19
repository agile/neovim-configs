local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
  install_path }
end

vim.cmd [[packadd packer.nvim]]

-- kind of prefer to be explicit about when I want to run PackerSync?
-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd [[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]]

local ok, packer = pcall(require, "packer")
if not ok then
  return
end

packer.startup(function(use)
  ---- Package manager
  use "wbthomason/packer.nvim"

  use {
    -- Search engine
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  }

  -- themes
  use "~/personal/lushy-blues"
  use "rktjmp/lush.nvim"
  use "Mofiqul/vscode.nvim"
  use "folke/tokyonight.nvim"
  use {
    "catppuccin/nvim",
    as = "catppuccin"
  }
  use {
    "rose-pine/neovim",
    as = "rose-pine",
  }

  ---- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "p00f/nvim-ts-rainbow",                         -- Open/Close node coloring
      "nvim-treesitter/nvim-treesitter-textobjects",  -- identify comments
      "nvim-treesitter/playground",                   -- View treesitter information directly in Neovim
      "JoosepAlviste/nvim-ts-context-commentstring",  -- commentstring
      "phelipetls/jsonpath.nvim",                     -- Show jq like path in json under cursor
    },
    run = ":TSUpdate",
  }

  -- Conveniences
  use { "theprimeagen/harpoon" }

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},

      { -- nvim-cmp extensions
        "onsails/lspkind.nvim",                 -- VSCode like item type icons
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

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    },
  }
end)
