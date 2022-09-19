-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
})

-- Disable comment new line
vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove { "c", "r", "o" }
    end,
})

vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
    pattern = "tsconfig.json",
    callback = function()
        vim.opt.filetype = "jsonc"
    end,
})

-- " open diff of index in vsplit if editing git commit msg
-- autocmd BufReadPost COMMIT_EDITMSG
--   \ exe "vnew" |
--   \ exe "set bt=nofile ft=diff" |
--   \ exe "silent r! git diff --cached" |
--   \ exe "normal gg" |
--   \ exe "normal :wincmd w" |
--   \ exe "normal ggi"

-- vim.api.nvim_create_autocmd("BufReadPost COMMIT_EDITMSG"

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
