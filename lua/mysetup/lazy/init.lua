return {
    { -- Align the things!
      "godlygeek/tabular",
      cmd = { "Tabularize" },
    },
    "tpope/vim-sleuth", -- autodetect tabstop/shiftwidth
    "thalesmello/lkml.vim", -- Lookml Syntax

    -- Git conveniences..
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    {
      -- Add git related info in the signs columns and popups
      "lewis6991/gitsigns.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      config = function()
        local gitsigns = require("gitsigns")

        -- see https://github.com/lewis6991/gitsigns.nvim
        gitsigns.setup {
            signs = {
                -- add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                -- change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
                -- delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                -- topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                -- changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },

                add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                change = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
                delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
            }
        }
      end,
    },

    -- File jump anchors
    {
      "theprimeagen/harpoon",
      config = function()
        local mark = require("harpoon.mark")

        vim.keymap.set("n", "<leader>a", mark.add_file)

        local ui = require("harpoon.ui")
        vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

        vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
        vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
        vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
        vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
      end
    },
    {
      "theprimeagen/refactoring.nvim",
      config = function()
        require("refactoring").setup({
          -- see https://github.com/ThePrimeagen/refactoring.nvim
        })
      end
    },
}
