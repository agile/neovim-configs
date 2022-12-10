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

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float {
                border = "single" -- "rounded"
            }
        end,
        prompt_border = "single" -- "rounded"
    },
    git = {
        clone_timeout = 600
    },
    auto_clean = true,
    compile_on_sync = false
}

require("packer").startup(function(use)
    ---- Package manager
    use "wbthomason/packer.nvim"

    ---- UI Themes
    -- See lua/theme.lua for configurations
    -- use "agile/lushy-blues"
    -- using a local copy while I derp it up
    use "~/personal/lushy-blues"
    use "rktjmp/lush.nvim"
    use "Mofiqul/vscode.nvim"
    use "folke/tokyonight.nvim"
    use {
        "catppuccin/nvim",
        as = "catppuccin"
    }

    ---- UI

    -- Lots of things use this to provide fancy icons for various things
    -- requires nerdfonts be installed
    -- https://github.com/kyazdani42/nvim-web-devicons
    use "kyazdani42/nvim-web-devicons"

    use {
        -- buffer/tab decorations/styles
        "akinsho/bufferline.nvim",
        requires = {
          "kyazdani42/nvim-web-devicons",
          -- delete buffers/close files
          -- maybe check out one of the derivatives https://github.com/moll/vim-bbye/network
          -- or https://github.com/famiu/bufdelete.nvim
          -- or https://github.com/kazhala/close-buffers.nvim
          -- or https://github.com/marklcrns/vim-smartq
          "moll/vim-bbye",
        },
        config = require "plugins.configs.bufferline"
    }
    -- keybinding hints popup when typing commands https://github.com/folke/which-key.nvim
    use "folke/which-key.nvim"

    use {
        "nvim-zh/colorful-winsep.nvim",
        config = require "plugins.configs.colorful-winsep"
    }

    use {
        -- Smoother scroll
        "karb94/neoscroll.nvim",
        config = require "plugins.configs.neoscroll"
    }
    -- use {
    --     -- Better looking folding
    --     "kevinhwang91/nvim-ufo",
    --     requires = "kevinhwang91/promise-async",
    --     config = require "plugins.configs.ufo"
    -- }

    use {
        -- Scroll bar
        "petertriho/nvim-scrollbar",
        config = require "plugins.configs.scrollbar"
    }

    use {
        "SmiteshP/nvim-navic",
        config = require "plugins.configs.navic",
        requires = {
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
    }

    use {
        -- Status bar
        "nvim-lualine/lualine.nvim",
        requires = {
            "arkav/lualine-lsp-progress",
            { -- statusline/winbar component to display code context
              "SmiteshP/nvim-navic",
              requires = "neovim-nvim-lspconfig",
            },
            -- "rmagatti/auto-session",
            { "kyazdani42/nvim-web-devicons", opt = true },
        },
        config = require "plugins.configs.lualine"
    }
    -- See my note above, think I wanna wire up navic instead
    -- use {
    --     -- Status line component that shows context of the current cursor position in file.
    --     "SmiteshP/nvim-gps",
    --     requires = "nvim-treesitter/nvim-treesitter",
    --     config = require "plugins.configs.gps"
    -- }

    use {
        -- Pretty list for showing diagnostics, references, telescope results, quickfix and location lists
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = require "plugins.configs.trouble"
    }
    use {
        -- Code outline window for skimming and quick navigation
        "stevearc/aerial.nvim",
        config = require "plugins.configs.aerial"
    }
    use "rcarriga/nvim-notify" -- Popup notifications
    use {
        -- Tree file explorer
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
        config = require "plugins.configs.neotree"
    }
    use {
        -- sweet ui for LSP diags, actions, etc..
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = require "plugins.configs.lspsaga"
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
        config = require "plugins.configs.treesitter"
    }


    ---- Utilities
    use "lewis6991/impatient.nvim"   -- Startup performance enhancer
    use "gpanders/editorconfig.nvim" -- support for .editorconfig files https://editorconfig.org/
    use { "godlygeek/tabular", cmd = { "Tabularize" } } -- align the things!

    use {
        -- Search engine
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = require "plugins.configs.telescope"
    }
    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make"
    }
    use {
        -- Add indentation guides even on blank lines
        "lukas-reineke/indent-blankline.nvim",
        config = require "plugins.configs.indent"
    }
    use {
        -- Autoclose brackets, parentheses...
        "windwp/nvim-autopairs",
        config = require "plugins.configs.autopairs"
    }
    use {
        -- Autochange open/close chars
        "kylechui/nvim-surround",
        config = require "plugins.configs.surround"
    }
    use {
        -- Colorize written color codes (#02F1AA, rgb(0,10,20)...)
        "NvChad/nvim-colorizer.lua",  -- using NvChad's fork (from norcalli) since it's maintained
        config = require "plugins.configs.colorizer"
    }
    use {
        -- Clipboard manager
        "AckslD/nvim-neoclip.lua",
        requires = "nvim-telescope/telescope.nvim",
        config = require "plugins.configs.neoclip"
    }
    use {
        --- Improved terminal toggle
        "akinsho/toggleterm.nvim",
        tag = "v2.*",
        config = require "plugins.configs.toggleterm"
    }
    use {
        -- More text targets to operate on https://github.com/wellle/targets.vim
        "wellle/targets.vim"
    }
    use {
        -- Automatically highlighting other uses of the current word under the cursor
        "RRethy/vim-illuminate"
    }
    -- use {
    --     --  Aims to provide a simple, unified, single tabpage interface that lets you easily review all changed files for any git rev
    --     "sindrets/diffview.nvim",
    --     requires = "nvim-lua/plenary.nvim"
    -- }

    ---- Comments
    use {
        "numToStr/Comment.nvim",
        config = require "plugins.configs.comment",
    }
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = require "plugins.configs.todo"
    }

    ---- LSP/DAP

    -- An LSP installer/managment plugin
    use {
        "williamboman/mason.nvim",
        config = require "plugins.configs.mason"
    }
    -- Core maintained LSP helpers
    use {
        "neovim/nvim-lspconfig",
        -- deferred to lsp.lua
        -- config = require "plugins.configs.lspconfig"
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
        config = require "plugins.configs.metals",
    }
    -- Java LSP extensions
    use "mfussenegger/nvim-jdtls"

    -- Lookml Syntax
    use "thalesmello/lkml.vim"

    -- Debug
    use "mfussenegger/nvim-dap"
    use {
        "jbyuki/one-small-step-for-vimkind",
        config = require "plugins.configs.one-small-step-for-vimkind"
    }
    use {
        "rcarriga/nvim-dap-ui",
        config = require "plugins.configs.dapui"
    }
    use {
        "nvim-telescope/telescope-dap.nvim",
        requires = { "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap" },
        config = require "plugins.configs.telescopedap"
    }

    ---- Snippets
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"

    ---- Completion
    use {
        "hrsh7th/nvim-cmp",
        requires = {
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

            -- LSP Signature completions (need to compare with hrsh7th's)
            -- use "ray-x/lsp_signature.nvim"
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = require "plugins.configs.cmp"
    }
    -- use {"ellisonleao/glow.nvim"} -- markdown preview
    use {
        "iamcco/markdown-preview.nvim",
        -- run = function() vim.fn["mkdp#util#install"]() end,
        run = "cd app && npm install",
        -- setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        -- ft = { "markdown" },
        config = require "plugins.configs.markdown-preview",
    }

    ---- Git
    use {
        -- Add git related info in the signs columns and popups
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = require "plugins.configs.gitsigns"
    }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
