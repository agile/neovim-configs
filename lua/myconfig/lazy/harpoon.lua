return {
  "theprimeagen/harpoon",
  config = function()
    local mark = require("harpoon.mark")

    vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon file" })

    local ui = require("harpoon.ui")
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon menu" })

    vim.keymap.set("n", "<C-1>", function() ui.nav_file(1) end, { desc = "Harpoon file 1" })
    vim.keymap.set("n", "<C-2>", function() ui.nav_file(2) end, { desc = "Harpoon file 2" })
    vim.keymap.set("n", "<C-3>", function() ui.nav_file(3) end, { desc = "Harpoon file 3" })
    vim.keymap.set("n", "<C-4>", function() ui.nav_file(4) end, { desc = "Harpoon file 4" })
  end
}
