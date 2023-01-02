local ok, plenary_reload = pcall(require, "plenary.reload")
if not ok then
  reloader = require
else
  reloader = plenary_reload.reload_module
end


vim.g.is_win = (vim.fn.has("win32") or vim.fn.has("win64")) and true or false
vim.g.is_linux = (vim.fn.has("unix") and (not vim.fn.has("macunix"))) and true or false
vim.g.is_mac  = vim.fn.has("macunix") and true or false

P = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(...)
  return reloader(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end
