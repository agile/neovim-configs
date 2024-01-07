local autocmd = vim.api.nvim_create_autocmd
local autogrp = vim.api.nvim_create_augroup("MyAutoCommands", { clear = true })

-- Highlight on yank
autocmd("TextYankPost", {
  group = autogrp,
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
  group = autogrp,
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove { "c", "r", "o" }
  end,
})

-- Override filetypes
autocmd({"BufRead","BufNewFile"}, {
  group = autogrp,
  pattern = "tsconfig.json",
  callback = function()
    vim.opt.filetype = "jsonc"
  end,
})
-- autocmd("BufRead,BufNewFile", {
--     group = autogrp,
--     pattern = "*.hcl",
--     callback = function()
--         vim.opt.filetype = "terraform"
--     end,
-- })

-- Remove trailing spaces
-- " http://vimcasts.org/episodes/tidying-whitespace/
-- function! <SID>StripTrailingWhitespaces()
--     " Preparation: save last search, and cursor position.
--     let _s=@/
--     let l = line(".")
--     let c = col(".")
--     " Do the business:
--     %s/\s\+$//e
--     " Clean up: restore previous search history, and cursor position
--     let @/=_s
--     call cursor(l, c)
-- endfunction
-- " when would I NOT want to strip trailing whitespace?
-- autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
-- " autocmd BufWritePre *.md,*.markdown,*.sql,*.sh,*.scala,*.sbt,*.go,*.py,*.js,*pp,*.c,*.cc,*.h,*.rb,*.y*ml :call <SID>StripTrailingWhitespaces()
-- naive version..
-- autocmd({"BufWritePre"}, {
--   group = autogrp,
--   pattern = "*",
--   command = [[%s/\s+$//e]],
-- })

-- " open diff of index in vsplit if editing git commit msg
-- autocmd BufReadPost COMMIT_EDITMSG
--   \ exe "vnew" |
--   \ exe "set bt=nofile ft=diff" |
--   \ exe "silent r! git diff --cached" |
--   \ exe "normal gg" |
--   \ exe "normal :wincmd w" |
--   \ exe "normal ggi"

-- autocmd("BufReadPost COMMIT_EDITMSG"
autocmd("BufReadPost", {
  group = autogrp,
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

-- "jump to last cursor position when opening a file
-- "dont do it when writing a commit log entry
-- function! SetCursorPosition()
--     if &filetype !~ 'commit\c'
--         if line("'\"") > 0 && line("'\"") <= line("$")
--             exe "normal g`\""
--         endif
--     end
-- endfunction
-- autocmd BufReadPost * call SetCursorPosition()
--
-- This should effectively be the same..
autocmd('BufReadPost', {
  callback = function()
    -- if it's not a commit message, jump to last position we were at in the file
    if not vim.bo.filetype:match("^.*commit$") then
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end
  end,
})
