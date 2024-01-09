-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--   vim.notify("Installing lazy...")
--   vim.fn.system({
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "https://github.com/folke/lazy.nvim.git",
--     "--branch=stable", -- latest stable release
--     lazypath,
--   })
-- end


-- Update lazy to use the exact sha we've got pinned
-- https://github.com/folke/lazy.nvim/issues/287#issuecomment-1370876298
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.notify("Installing package manager...")
  vim.fn.system({
    "git",
    "clone",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
  local f = io.open(vim.fn.stdpath("config") .. "/lazy-lock.json", "r")
  if f then
    local data = f:read("*a")
    local lock = vim.json.decode(data)
    vim.fn.system { "git", "-C", lazypath, "checkout", lock["lazy.nvim"].commit }
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load all the setup from the lua/myconfig/lazy path
require("lazy").setup("myconfig.lazy")
