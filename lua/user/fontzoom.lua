vim.g.gui_font_default_size = 11
vim.g.gui_font_size = vim.g.gui_font_default_size
-- vim.g.gui_font_face = "FiraCode Nerd Font" -- don't really like the ligatures..
--
-- These 3 are ok, I think..
-- vim.g.gui_font_face = "Hack Nerd Font"
-- vim.g.gui_font_face = "UbuntuMono Nerd Font"
vim.g.gui_font_face = "DejaVuSansMono Nerd Font"

RefreshGuiFont = function()
  vim.opt.guifont = string.format("%s:h%s",vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
  if vim.g.gui_font_size + delta > 2 then
    vim.g.gui_font_size = vim.g.gui_font_size + delta
  end
  RefreshGuiFont()
end

ResetGuiFont = function ()
  vim.g.gui_font_size = vim.g.gui_font_default_size
  RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

-- Keymaps

local opts = { noremap = true, silent = true }

vim.keymap.set({'n', 'i'}, "<C-+>", function() ResizeGuiFont(1)  end, opts)
vim.keymap.set({'n', 'i'}, "<C-->", function() ResizeGuiFont(-1) end, opts)
vim.keymap.set({'n', 'i'}, "<C-ScrollWheelUp>", function() ResizeGuiFont(1)  end, opts)
vim.keymap.set({'n', 'i'}, "<C-ScrollWheelDown>", function() ResizeGuiFont(-1) end, opts)
vim.keymap.set({'n', 'i'}, "<C-BS>", function() ResetGuiFont() end, opts)
