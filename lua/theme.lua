local M = {}

M.colors = {
    bg = "#2e3440",
    fg = "#ECEFF4",
    red = "#bf616a",
    orange = "#d08770",
    yellow = "#ebcb8b",
    blue = "#5e81ac",
    green = "#a3be8c",
    cyan = "#88c0d0",
    magenta = "#b48ead",
    purple = "#534671",
    pink = "#FFA19F",
    grey1 = "#f8fafc",
    grey2 = "#f0f1f4",
    grey3 = "#eaecf0",
    grey4 = "#d9dce3",
    grey5 = "#c4c9d4",
    grey6 = "#b5bcc9",
    grey7 = "#929cb0",
    grey8 = "#8e99ae",
    grey9 = "#74819a",
    grey10 = "#616d85",
    grey11 = "#464f62",
    grey12 = "#3a4150",
    grey13 = "#333a47",
    grey14 = "#242932",
    grey15 = "#1e222a",
    grey16 = "#1c1f26",
    grey17 = "#0f1115",
    grey18 = "#0d0e11",
    grey19 = "#020203"
}

M.init = function(theme_name)
    M.theme_name = theme_name
    local _ok, theme = pcall(require, M.theme_name)
    if not _ok then
        print("Theme: " .. theme_name .. " failed to load")
        return
    end

    if M.theme_name == 'tokyonight' then
        -- https://github.com/folke/tokyonight.nvim#%EF%B8%8F-configuration
        theme.setup({
            style = 'night',
            lualine_bold = true,
            -- see ~/.local/share/nvim/site/pack/packer/start/tokyonight.nvim/extras/lua_tokyonight_night.lua
            on_colors = function(colors)
                colors.hint = colors.purple
                -- colors.error = "#FF0000"
                colors.bg = "#060609" -- "#000000"
                colors.bg_dark = "#000000"
                colors.bg_sidebar = "#000000"
            end,
            on_highlights = function(hl, c)
                hl.Search = { bg = c.yellow, fg = c.black }
            end,
        })
        theme.load()
    elseif M.theme_name == 'onedark' then
        theme.setup { style = 'darker' }
        theme.load()
    elseif M.theme_name == 'material' then
        vim.g.material_style = "oceanic"
        vim.cmd.colorscheme("material")
    elseif M.theme_name == 'onedarkpro' then
        vim.o.background = "dark"
        theme.load()
    elseif M.theme_name == 'tokyodark' then
        vim.g.tokyodark_transparent_background = false
        vim.g.tokyodark_enable_italic_comment = true
        vim.g.tokyodark_enable_italic = true
        vim.g.tokyodark_color_gamma = "0.0"
        vim.cmd.colorscheme("tokyodark")
    elseif M.theme_name == 'catppuccin' then
        vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
        vim.cmd.colorscheme("catppuccin")
    elseif M.theme_name == 'dracula' then
        theme.setup {}
        theme.load()
    elseif M.theme_name == 'draculanight' then
        theme.setup {}
        theme.load()
    elseif M.theme_name == 'vscode' then
        -- see https://github.com/Mofiqul/vscode.nvim
        theme.setup {
            -- Enable transparent background
            -- transparent = true,

            -- Enable italic comment
            -- italic_comments = true,

            -- Disable nvim-tree background color
            -- disable_nvimtree_bg = true,

            -- Override colors (see ./lua/vscode/colors.lua)
            -- color_overrides = {
            --     vscLineNumber = '#FFFFFF',
            -- },

            -- Override highlight groups (see ./lua/vscode/theme.lua)
            -- group_overrides = {
            --     -- this supports the same val table as vim.api.nvim_set_hl
            --     -- use colors from this colorscheme by requiring vscode.colors!
            --     Cursor = { fg=colors.purple, bg=colors.green, bold=true },
            -- },
        }
    else
        vim.cmd.colorscheme(M.theme_name)
    end
end

return M
