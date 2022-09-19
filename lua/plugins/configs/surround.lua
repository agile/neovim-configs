local ok, surround = pcall(require, "nvim-surround")
if not ok then
    return
end

-- see https://github.com/kylechui/nvim-surround
surround.setup {}
