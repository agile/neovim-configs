return {
  "folke/trouble.nvim",
  win = {
    position = "left",
  },
  config = function()
    require("trouble").setup()
    vim.keymap.set("n", "<leader>td", function()
      require("trouble").toggle()
    end)
    vim.keymap.set("n", "]d", function()
      require("trouble").next({skip_groups=true, jump=true})
    end)
    vim.keymap.set("n", "[d", function()
      require("trouble").prev({skip_groups=true, jump=true})
    end)
  end
}
