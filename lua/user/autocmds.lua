-- " open diff of index in vsplit if editing git commit msg
-- autocmd BufReadPost COMMIT_EDITMSG
--   \ exe "vnew" |
--   \ exe "set bt=nofile ft=diff" |
--   \ exe "silent r! git diff --cached" |
--   \ exe "normal gg" |
--   \ exe "normal :wincmd w" |
--   \ exe "normal ggi"

-- vim.api.nvim_create_autocmd("BufReadPost COMMIT_EDITMSG"
--

local commits = vim.api.nvim_create_augroup("Commits", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
  group=commits,
  pattern = "*COMMIT_EDITMSG",
  callback = function()
    vim.cmd([[
      exe "vnew" |
      exe "set bt=nofile ft=diff" |
      exe "silent r! git diff --cached" |
      exe "normal gg" |
      exe "normal :wincmd w" |
      exe "normal ggi"
    ]])
  end,
})
