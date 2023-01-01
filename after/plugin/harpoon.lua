local _mark, mark = pcall(require, "harpoon.mark")
if not _mark then
    return
end

vim.keymap.set("n", "<leader>a", mark.add_file)

local _ui, ui = pcall(require, "harpoon.ui")
if not _ui then
    return
end
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
