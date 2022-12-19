function SetMyColorPrefs(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)

  -- override window bg settings to force them to be transparent
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

SetMyColorPrefs()
