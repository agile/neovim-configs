local ok, winsep = pcall(require, "colorful-winsep")
if not ok then
    return
end

-- see https://github.com/nvim-zh/colorful-winsep.nvim
winsep.setup {
      direction = {
    down = "j",
    left = "h",
    right = "l",
    up = "k"
  },
  highlight = {
    guibg = "bg",
    guifg = "#957CC6"
  },
  interval = 100,
  no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest" },
  symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
  win_opts = {
    relative = "editor",
    style = "minimal"
  }
}
