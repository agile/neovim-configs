local _scrollbar, scrollbar = pcall(require, "scrollbar")
if not _scrollbar then
    return
end

local _colors, colors = pcall(require, "theme")
if _colors then
  -- See https://github.com/petertriho/nvim-scrollbar#example-config-with-tokyonightnvim-colors
  scrollbar.setup {
      handle = {
          color = colors.blue
      }
  }
else
  scrollbar.setup()
end
