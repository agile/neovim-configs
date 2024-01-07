return {
  {
    {
      "agile/lushy-blues",
      dir = "~/personal/lushy-blues",
      dependencies = {
        "NvChad/nvim-colorizer.lua",
        "rktjmp/lush.nvim",
        "Mofiqul/vscode.nvim",
        "folke/tokyonight.nvim",
        "navarasu/onedark.nvim", -- Theme inspired by Atom
        {
          "catppuccin/nvim",
          name = "catppuccin",
        },
      },

      config = function()
        -- UI theme
        -- local default_theme = "lushy-blues"
        local default_theme = "tokyonight"
        local themename = os.getenv("THEME") or "lushy-blues"
        -- local themename = "draculanight"
        -- local themename = "vscode"
        -- local themename = "tokyonight"
        local _theme, theme = pcall(require, themename)
        if _theme then
          if themename == "tokyonight" then
            theme.setup {
              style = "night",
            }
          elseif themename == "catppuccin" then
            theme.setup {
              flavour = "mocha",
            }
          end

          vim.cmd.colorscheme(themename)
        else
          -- print("Failed to load theme: " .. themename .. ", using default colorscheme: " .. default_theme)
          vim.cmd.colorscheme(themename)
        end

        -- function SetMyColorPrefs(color)
        --   color = color or default_theme
        --   vim.cmd.colorscheme(color)
        --
        --   -- override window bg settings to force them to be transparent
        --   vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        --   vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        -- end
        --
        -- SetMyColorPrefs()

        -- override window bg settings to force them to be transparent
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

        local _colorizer, colorizer = pcall(require, "colorizer")
        if _colorizer then
          colorizer.setup({
            filetypes = { "*" }
          })
          -- #4444ff
        end
      end
    },
  }
}
