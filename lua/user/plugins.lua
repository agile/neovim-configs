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
  use "folke/tokyonight.nvim"
  use "rafi/awesome-vim-colorschemes"
  use "bluz71/vim-moonfly-colors"
  use "bluz71/vim-nightfly-guicolors"
  use "rockerBOO/boo-colorscheme-nvim"
  use { "catppuccin/nvim", as = "catppuccin" }
  use "rktjmp/lush.nvim"

  -- use "hrsh7th/nvim-cmp"       -- Basic completion support
  use({
    -- this one looks pretty neat, but didn't seem to work?
    "hrsh7th/nvim-cmp",       -- Basic completion support
    requires = {
      "KadoBOT/cmp-plugins",
      config = function()
        require("cmp-plugins").setup({ files = { "plugins.lua", "lua/plugins" } })
      end,
    },
  })

  use "hrsh7th/cmp-buffer"     -- Buffer completions
  use "hrsh7th/cmp-path"       -- Path completions
  use "hrsh7th/cmp-cmdline"    -- Command line completions
  use "hrsh7th/cmp-calc"       -- Math completions
  use "hrsh7th/cmp-nvim-lua"   -- Lua API completions
  use "lttr/cmp-jira"          -- JIRA completions

  use "L3MON4D3/LuaSnip"       -- Snippet Completions
  use "rafamadriz/friendly-snippets"  -- collection of snippets

  use "onsails/lspkind.nvim"   -- symbols for diagnostics/menus

  -- support for .editorconfig files https://editorconfig.org/
  use "editorconfig/editorconfig-vim"


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
