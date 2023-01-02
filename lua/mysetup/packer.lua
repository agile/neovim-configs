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
  use 'navarasu/onedark.nvim' -- Theme inspired by Atom
  use {
    "catppuccin/nvim",
    as = "catppuccin",
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
    "VonHeikemen/lsp-zero.nvim",
    requires = {
      -- LSP Support
      {"neovim/nvim-lspconfig"},
      {"jose-elias-alvarez/null-ls.nvim"},
      {"williamboman/mason.nvim"},
      {"williamboman/mason-lspconfig.nvim"},
      {"jay-babu/mason-null-ls.nvim"},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},

      { -- nvim-cmp extensions
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

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    },
  }

  -- Status line
  use {
    "nvim-lualine/lualine.nvim",
    requires = {
      "arkav/lualine-lsp-progress",
      { -- statusline/winbar component to display code context
        "SmiteshP/nvim-navic",
      },
      -- "rmagatti/auto-session",
      { "kyazdani42/nvim-web-devicons" },
    },
  }
  -- use {
  --   -- buffer/tab decorations/styles
  --   "akinsho/bufferline.nvim",
  --   requires = {
  --     "kyazdani42/nvim-web-devicons",
  --     -- delete buffers/close files
  --     -- maybe check out one of the derivatives https://github.com/moll/vim-bbye/network
  --     -- or https://github.com/famiu/bufdelete.nvim
  --     -- or https://github.com/kazhala/close-buffers.nvim
  --     -- or https://github.com/marklcrns/vim-smartq
  --     "moll/vim-bbye",
  --   },
  -- }
  use {
    -- Add git related info in the signs columns and popups
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  }
  -- Rust LSP extensions
  use {
    "simrat39/rust-tools.nvim",
    requires = "nvim-lua/plenary.nvim"
  }
  -- Scala
  use {
    "scalameta/nvim-metals",
    requires = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
  }
  -- Lookml Syntax
  use "thalesmello/lkml.vim"

  -- Utilities
  use "gpanders/editorconfig.nvim" -- support for .editorconfig files https://editorconfig.org/
  use { "godlygeek/tabular", cmd = { "Tabularize" } } -- align the things!
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

end)
