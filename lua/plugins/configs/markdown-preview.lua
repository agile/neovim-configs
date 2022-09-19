vim.g.mkdp_filetypes = {
  "markdown",
}

vim.g.mkdp_auto_start = 1 -- set to 1, nvim will open the preview window after entering the markdown buffer
vim.g.mkdp_auto_close = 0 -- set to 1, nvim will close the preview window after leaving the markdown buffer
vim.g.mkdp_browser = "/Applications/Firefox.app/Contents/MacOS/firefox"   -- path to browser to use


-- normal/insert
-- <Plug>MarkdownPreview
-- <Plug>MarkdownPreviewStop
-- <Plug>MarkdownPreviewToggle
-- example
-- nmap <C-s> <Plug>MarkdownPreview
-- nmap <M-s> <Plug>MarkdownPreviewStop
-- nmap <C-p> <Plug>MarkdownPreviewToggle
