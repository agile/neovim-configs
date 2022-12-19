local autocmd = vim.api.nvim_create_autocmd
local autogrp = vim.api.nvim_create_augroup

-- Highlight on yank
local highlight_group = autogrp("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    group = highlight_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
          higroup = "IncSearch",
          timeout = 40,
        })
    end,
})

-- Disable comment new line
autocmd("BufWinEnter", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove { "c", "r", "o" }
    end,
})

autocmd("BufRead,BufNewFile", {
    pattern = "tsconfig.json",
    callback = function()
        vim.opt.filetype = "jsonc"
    end,
})

-- Remove trailing spaces
autocmd({"BufWritePre"}, {
  group = MySetupGroup, 
  pattern = "*",
  command = [[%s/\s+$//e]],
})

-- " open diff of index in vsplit if editing git commit msg
-- autocmd BufReadPost COMMIT_EDITMSG
--   \ exe "vnew" |
--   \ exe "set bt=nofile ft=diff" |
--   \ exe "silent r! git diff --cached" |
--   \ exe "normal gg" |
--   \ exe "normal :wincmd w" |
--   \ exe "normal ggi"

-- autocmd("BufReadPost COMMIT_EDITMSG"

local commits = autogrp("Commits", { clear = true })
autocmd("BufReadPost", {
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
