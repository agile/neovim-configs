local ok, colorizer = pcall(require, "colorizer")
if not ok then
    return
end

-- see https://github.com/NvChad/nvim-colorizer.lua
colorizer.setup()
