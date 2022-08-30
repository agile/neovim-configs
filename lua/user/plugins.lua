local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim"    -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim"  -- Useful lua functions used by lots of plugins

  use "mortepau/codicons.nvim"  -- icon fonts

  -- color themes
  use {
    "folke/tokyonight.nvim",
    "rafi/awesome-vim-colorschemes",
    "bluz71/vim-moonfly-colors",
    "bluz71/vim-nightfly-guicolors",
    "rockerBOO/boo-colorscheme-nvim",
    { "catppuccin/nvim", as = "catppuccin" },
    "rktjmp/lush.nvim",
  }

  use {
    "hrsh7th/nvim-cmp",         -- Basic completion support
    requires = {
      "hrsh7th/cmp-buffer",     -- Buffer completions
      "hrsh7th/cmp-path",       -- Path completions
      "hrsh7th/cmp-cmdline",    -- Command line completions
      "hrsh7th/cmp-calc",       -- Math completions
      "hrsh7th/cmp-nvim-lua",   -- Lua API completions
      "hrsh7th/cmp-nvim-lsp",   -- LSP completions
      "lttr/cmp-jira",          -- JIRA completions
      "onsails/lspkind.nvim",   -- symbols for diagnostics/menus
      {
        "L3MON4D3/LuaSnip",     -- Snippet Completions
        requires = { "rafamadriz/friendly-snippets" },
      },
      {
        "KadoBOT/cmp-plugins",
        config = function()
          require("cmp-plugins").setup({ files = { "lua/user/plugins.lua" } })
        end,
      }
    },
  }

  -- support for .editorconfig files https://editorconfig.org/
  use "editorconfig/editorconfig-vim"

  -- LSP support
  use {
    -- "williamboman/mason.nvim",            -- Installers for varous LSPs
    -- "williamboman/mason-lspconfig.nvim",  -- Basic LSP configurations
    "neovim/nvim-lspconfig",                 -- Basic LSP configurations
    "williamboman/nvim-lsp-installer",       -- TODO: refactor to use Mason
  }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
  }

  -- TreeSitter
  use {
    "nvim-treesitter/nvim-treesitter", run = ":TSUpdate",
    requires = {
      "p00f/nvim-ts-rainbow",
      "nvim-treesitter/playground",
      "JoosepAlviste/nvim-ts-context-commentstring"
    }
  }

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  use "numToStr/Comment.nvim" -- Easily comment stuff

  use "lewis6991/gitsigns.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
