local ok, neoclip = pcall(require, "neoclip")
if not ok then
    return
end

-- see https://github.com/AckslD/nvim-neoclip.lua#configuration

neoclip.setup {
    default_register = '+',
}
require("telescope").load_extension("neoclip")

