-- tried space as leader key, stilll prefer comma
-- vim.g.mapleader = ','
-- vim.g.maplocalleader = ','
-- ok, giving it another go..
vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '
vim.g.is_win         = (vim.fn.has("win32") or vim.fn.has("win64")) and true or false
vim.g.is_linux       = (vim.fn.has("unix") and (not vim.fn.has("macunix"))) and true or false
vim.g.has_nix        = vim.fn.executable("nix") and true or false
vim.g.is_mac         = vim.fn.has("macunix") and true or false

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

--
-- Mostly taken from Primeagen's mappings
--
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer relative to current file" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move visual selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move visual selection up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join to prev line but keep cursor in same place" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half-page down jump but keep cursor in same place" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half-page up jump but keep cursor in same place" })
vim.keymap.set("n", "n", "nzzzv", { desc = "find next search match but keep cursor in same place" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "find prev search match but keep cursor in same place" })

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste keeping original copy" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank into system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "yank line-wise into system clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete without copying into clipboard" })

vim.keymap.set({ "n", "v" }, "Q", "gq", { desc = "format lines" })

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "format code via lsp" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "next error in quickfix" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "prev error in quickfix" })
vim.keymap.set("n", "<leader>H",
    function()
        local result = vim.treesitter.get_captures_at_cursor(0)
        print(vim.inspect(result))
    end
    -- ":TSHighlightCapturesUnderCursor<CR>"
    , { desc = "Show treesitter capture group for text object under cursor" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "next error in window" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "prev error in window" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "replace word under cursor in whole file" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true }, { desc = "make current file executable" })

-- vim.keymap.set("n", "<Esc>", "<cmd>noh<cr>", {desc = "Clear search highlights"})
vim.keymap.set("n", ";;", "<cmd>noh<cr>", { desc = "Clear search highlights" })

if vim.g.is_mac then
    -- copy/paste accommodations for stupid mac..
    vim.g.neovide_input_use_logo = true
    --  copy
    -- mac-style cmd-c
    vim.keymap.set("v", "<D-c>", [["+y]], { desc = "copy to clipboard" })
    -- shift-ctrl-c
    vim.keymap.set("v", "<S-C-c>", [["+y]], { desc = "copy to clipboard" })

    --  paste
    vim.keymap.set("n", "<D-v>", [["+p]], { desc = "paste from clipboard" })
    vim.keymap.set("i", "<D-v>", [[<Esc>"+pa]])
    vim.keymap.set("c", "<D-v>", [[<c-r>+]])
    -- shift-ctrl-v
    vim.keymap.set("n", "<S-C-v>", [["+p]], { desc = "paste from clipboard" })
    vim.keymap.set("i", "<S-C-v>", [[<Esc>"+pa]])
    vim.keymap.set("c", "<S-C-v>", [[<c-r>+]])

    -- undo
    vim.keymap.set("n", "<D-z>", "u")
    vim.keymap.set("i", "<D-z>", "<Esc>ua")
end

--
-- My old mappings
-- local i_opts = {
--     mode = "i",
--     prefix = "",
--     silent = true,
--     noremap = true,
--     nowait = true,
-- }
--
-- wk.register({
--     ["jk"] = { "<Esc>", "Normal mode switch" },
--     ["JK"] = { "<Esc>", "Normal mode switch" },
--     ["<a-d>"] = { "<Del>", "Handy DEL on insert mode" },
--     ["<a-j>"] = { "<ESC>:m .+1<cr>==gi", "[MOVE] Move block down" },
--     ["<a-k>"] = { "<ESC>:m .-2<cr>==gi", "[MOVE] Move block up" },
-- }, i_opts)
--
-- local n_opts = {
--     mode = "n",
--     prefix = "",
--     silent = true,
--     noremap = true,
--     nowait = true,
-- }
--
-- wk.register({
--     -- [","] = { "@:", "Repeat last command" },
--     ["<leader>r"] = { "<cmd>reg<cr>", "Show registers" },
--     ["<leader>o"] = { "o<ESC>", "New line in normal mode" },
--     ["<leader>O"] = { "O<ESC>", "New line before in normal mode" },
--     ["<a-j>"] = { ":m .+1<cr>==", "[MOVE] Move line down" },
--     ["<a-k>"] = { ":m .-2<cr>==", "[MOVE] Move line up" },
--
--     ["t"] = { '"_', "Set black hole registry" },
--     ["<leader>p"] = { '"_diwP', "Replace word with paste" }, -- "_ is the black hole registry. Deleting in this registry wont overwrite default registry
--     [";;"] = { "<cmd>noh<cr>", "Clean search highlights" },
--
--     ["<c-Up>"] = { "<cmd>resize +2<cr>", "[WINDOW] Make window taller" },
--     ["<c-Down>"] = { "<cmd>resize -2<cr>", "[WINDOW] Make window shorter" },
--     ["<c-Left>"] = { "<cmd>vertical resize -2<cr>", "[WINDOW] Make window narrower" },
--     ["<c-Right>"] = { "<cmd>vertical resize +2<cr>", "[WINDOW] Make window wider" },
--
--     -- Better window navigation
--     ["<c-h>"] = { "<c-w>h", "[WINDOW] Focus in left window" },
--     ["<c-j>"] = { "<c-w>j", "[WINDOW] Focus in bottom window" },
--     ["<c-k>"] = { "<c-w>k", "[WINDOW] Focus in top window" },
--     ["<c-l>"] = { "<c-w>l", "[WINDOW] Focus in right window" },
--
--     ["<a-l>"] = { "<cmd>bn<cr>", "[BUFFER] Go previous buffer" },
--     ["<a-h>"] = { "<cmd>bp<cr>", "[BUFFER] Go next buffer" },
--     ["<a-w>"] = { "<cmd>bd<cr>", "[BUFFER] Close current buffer" },
--     ["<a-q>"] = { "<cmd>%bd|e#|bd#<cr>", "[BUFFER] Close other buffers" },
--
--     ["--"] = { "zR", "[FOLDS] Expand all folds" },
--     ["_"] = { "zM", "[FOLDS] Close all folds" },
--
--
--     ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "[LSP] Hover"},
--     -- ["K"] = { "<cmd>Lspsaga hover_doc<cr>", "[LSP] Hover" },
--
--     ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "[LSP] Go to definition" },
--     ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "[LSP] Go to declaration" },
--     ["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "[LSP] Go to implementation" },
--     ["gl"] = { "<cmd>Lspsaga codelens<cr>", "[LSP] Code Lens" },
--     ["go"] = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "[LSP] Def of type symbol" },
--     ["gr"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "[LSP] Go to references" },
--
--     ["gk"] = { "<cmd>Lspsaga hover_doc<cr>", "[LSP] Hover" },
--     ["gf"] = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "[LSP] Format code" },
--
--
--     ["<leader>t"] = {
--         name = "[TELESCOPE]",
--         f = { "<cmd>Telescope find_files hidden=false no_ignore=true<cr>", "[TELESCOPE] Find File" },
--         s = { "<cmd>Telescope grep_string<cr>", "[TELESCOPE] Find files using grep in file names" },
--         g = { "<cmd>Telescope live_grep<cr>", "[TELESCOPE] Find File by live grep (search content inside file)" },
--         b = { "<cmd>Telescope buffers<cr>", "[TELESCOPE] Find buffers" },
--         h = { "<cmd>Telescope help_tags<cr>", "[TELESCOPE] Help tags" },
--         m = { "<cmd>Telescope marks<cr>", "[TELESCOPE] Marks" },
--         r = { "<cmd>Telescope oldfiles<cr>", "[TELESCOPE] Recent files" },
--         z = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "[TELESCOPE] Current buffer fuzzy find" },
--         t = { "<cmd>TodoTelescope<cr>", "[TELESCOPE] TODO list" },
--         --o = { "<cmd>Telescope current_buffer_tags<cr>", "[TELESCOPE] Current buffer tags"},
--         c = { "<cmd>Telescope command_history<cr>", "[TELESCOPE] Search command history" },
--         x = { "<cmd>Telescope neoclip<cr>", "[TELESCOPE] Search in clipboard manager" },
--         p = { "<cmd>Telescope projects<cr>", "[TELESCOPE] Search projects" },
--         db = { "<cmd>Telescope dap list_breakpoints<cr>", "[TELESCOPE DAP] Breakpoints" },
--         dc = { "<cmd>Telescope dap configurations<cr>", "[TELESCOPE DAP] Debug configurations" },
--         dv = { "<cmd>Telescope dap variables<cr>", "[TELESCOPE DAP] Varibles" },
--     },
--     -- VScode similar
--     ["<c-p>"] = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "[TELESCOPE] Find File" },
--
--     ["<c-1>"] = { "<cmd>NeoTreeShowToggle<cr>", "[NEOTREE] Toggle" },
--     ["<c-2>"] = { "<cmd>TroubleToggle<cr>", "[TROUBLE] Toggle" },
--     ["<c-3>"] = { "<cmd>AerialToggle<cr>", "[AERIAL] Toggle" },
--
--     ["<leader>d"] = {
--         name = "[DAP debug]",
--         d = { "<cmd>DapContinue<cr>", "[DAP] Start/continue debug" },
--         k = { "<cmd>DapTerminate<cr>", "[DAP] Terminate" },
--         b = { "<cmd>DapToggleBreakpoint<cr>", "[DAP] Toggle breakpoint" },
--         cb = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
--             "[DAP] Set conditional breakpoint" },
--         lb = { "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
--             "[DAP] Set log point breakpoint" },
--         r = { "<cmd>DapToggleRepl", "[DAP] Repl open" },
--         l = { "<cmd>lua require'dap'.run_last()<cr>", "[DAP] Run last" },
--         o = { "<cmd>lua require'dapui'.open()<cr>", "[DAPUI] Open debugging UI" },
--         c = { "<cmd>lua require'dapui'.close()<cr>", "[DAPUI] Close debugging UI" },
--     },
--     ["<F2>"]  = { "<cmd>Lspsaga rename<cr>", "[LSP] Rename" },
--     ["<F4>"]  = { "<cmd>Lspsaga code_action<cr>", "[LSP] Code Action" },
--     ["<F10>"] = { "<cmd>lua require'dap'.step_over()<cr>", "[DAP] Step over" },
--     ["<F11>"] = { "<cmd>lua require'dap'.step_into()<cr>", "[DAP] Step into" },
--     ["<F12>"] = { "<cmd>lua require'dap'.step_out()<cr>", "[DAP] Step out" },
--
--     ["<leader>l"] = {
--         name = "[LSP]",
--         gr = { "<cmd>lua vim.lsp.buf.references()<cr>", "[LSP] Go to references" },
--         gd = { "<cmd>lua vim.lsp.buf.definition()<cr>", "[LSP] Go to definition" },
--         gD = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "[LSP] Go to declaration" },
--         gi = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "[LSP] Go to implementation" },
--         a = { "<cmd>Lspsaga code_action<cr>", "[LSP] Code actions" },
--         k = { "<cmd>Lspsaga hover_doc<cr>", "[LSP] Hover" },
--         -- map("n", "<leader>ws", '<cmd>lua require"metals".hover_worksheet()<CR>')
--         s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "[LSP] Signature help" },
--         ds = { "<cmd>lua vim.lsp.buf.document_symbol()<CR>", "[LSP] Document symbol" },
--         ws = { "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", "[LSP] Workspace symbol" },
--         f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "[LSP] Format code" },
--         rn = { "<cmd>Lspsaga rename<cr>", "[LSP] Rename" },
--         -- rn = { "<cmd>lua vim.lsp.buf.rename()<CR>", "[LSP] Rename"},
--
--         ca = { "<cmd>Lspsaga code_action<cr>", "[LSP] Code actions" },
--         -- ca = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "[LSP] Code actions" },
--         cl = { "<cmd>lua vim.lsp.codelens.run()<CR>", "[LSP] Code lens" },
--         -- FIXME: reconcile example metals mappings
--
--         -- map("n", "<leader>aa", "<cmd>lua vim.diagnostic.setqflist()<CR>") -- all workspace diagnostics
--         -- map("n", "<leader>ae", '<cmd>lua vim.diagnostic.setqflist({severity = "E"})<CR>') -- all workspace errors
--         -- map("n", "<leader>aw", '<cmd>lua vim.diagnostic.setqflist({severity = "W"})<CR>') -- all workspace warnings
--         -- map("n", "<leader>d", "<cmd>lua vim.diagnostic.setloclist()<CR>") -- buffer diagnostics only
--
--         -- map("n", "[c", "<cmd>lua vim.diagnostic.goto_prev { wrap = false }<CR>")
--         -- map("n", "]c", "<cmd>lua vim.diagnostic.goto_next { wrap = false }<CR>")
--
--         -- -- Example mappings for usage with nvim-dap. If you don't use that, you can
--         -- -- skip these
--         -- map("n", "<leader>dc", [[<cmd>lua require"dap".continue()<CR>]])
--         -- map("n", "<leader>dr", [[<cmd>lua require"dap".repl.toggle()<CR>]])
--         -- map("n", "<leader>dK", [[<cmd>lua require"dap.ui.widgets".hover()<CR>]])
--         -- map("n", "<leader>dt", [[<cmd>lua require"dap".toggle_breakpoint()<CR>]])
--         -- map("n", "<leader>dso", [[<cmd>lua require"dap".step_over()<CR>]])
--         -- map("n", "<leader>dsi", [[<cmd>lua require"dap".step_into()<CR>]])
--         -- map("n", "<leader>dl", [[<cmd>lua require"dap".run_last()<CR>]])
--     },
--     ["<leader>j"] = {
--         name = "[JDTLS]",
--         o = { "<cmd>lua require'jdtls'.organize_imports()<cr>", "[JDLTS] Organize imports" },
--     },
--
--     ["<C-\\>"] = { "<cmd>ToggleTerm<cr>", "[TOGGLETERM] Open new terminal" },
--
--     ["<leader>g"] = {
--         name = "[GIT]",
--         s = { "<cmd>Gitsigns toggle_signs<cr>", "[GIT] Toggle signs" },
--         h = { "<cmd>Gitsigns preview_hunk<cr>", "[GIT] Preview hunk" },
--         d = { "<cmd>Gitsigns diffthis<cr>", "[GIT] Diff" },
--         n = { "<cmd>Gitsigns next_hunk<cr>", "[GIT] Next hunk" },
--         p = { "<cmd>Gitsigns prev_hunk<cr>", "[GIT] Prev hunk" },
--     },
-- }, n_opts)
--
-- local v_opts = {
--     mode = "v",
--     nowait = true,
--     prefix = "",
--     silent = true,
--     noremap = true,
-- }
-- wk.register({
--     ["jk"] = { "<Esc>", "Normal mode switch" },
--     ["p"] = { '"_dP', "Paste without replacing what is was in clipboard" },
--     ["<"] = { "<gv", "[Indent] Indent left" },
--     [">"] = { ">gv", "[Indent] Indent right" },
--     ["<a-j>"] = { ":m '>+1<cr>gv=gv", "[MOVE] Move block down" },
--     ["<a-k>"] = { ":m '<-2<cr>gv=gv", "[MOVE] Move block up" },
-- }, v_opts)
--
-- local x_opts = {
--     mode = "x",
--     nowait = true,
--     prefix = "",
--     silent = true,
--     noremap = true,
-- }
-- wk.register({
--     ["<F4>"]  = { "<cmd>Lspsaga code_action<cr>", "[LSP] Code Action" },
-- }, x_opts)
--
-- wk.setup {}
--

-- Special mapping to allow dynamically changing gui font size for a zooming effect

vim.g.gui_font_default_size = 11
vim.g.gui_font_size = vim.g.gui_font_default_size
-- vim.g.gui_font_face = "FiraCode Nerd Font" -- don't really like the ligatures..
--
-- These 3 are ok, I think..
-- vim.g.gui_font_face = "Hack Nerd Font"
-- vim.g.gui_font_face = "UbuntuMono Nerd Font"

-- gah.. they renamed it
-- https://github.com/Homebrew/homebrew-cask-fonts/pull/7525/files#diff-a35365bc63e24c154699de2031a74d18df5469eadb02418ff6142f18aadde8da
-- vim.g.gui_font_face = "DejaVuSansMono Nerd Font"
-- the one I like, seemms to have issues with neovide now :(
-- vim.g.gui_font_face = "DejaVuSansM Nerd Font Mono"
-- vim.g.gui_font_face = "FiraCode Nerd Font" -- don't really like the ligatures..
-- Trying out this monaspace font for a bit..
vim.g.gui_font_face = "MonaspiceNe Nerd Font Mono"

RefreshGuiFont = function()
    vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
    if vim.g.gui_font_size + delta > 2 then
        vim.g.gui_font_size = vim.g.gui_font_size + delta
    end
    RefreshGuiFont()
end

ResetGuiFont = function()
    vim.g.gui_font_size = vim.g.gui_font_default_size
    RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

vim.keymap.set({ 'n', 'i' }, "<C-+>", function() ResizeGuiFont(1) end,
    { noremap = true, silent = true, desc = "Increase font size" })
vim.keymap.set({ 'n', 'i' }, "<C-->", function() ResizeGuiFont(-1) end,
    { noremap = true, silent = true, desc = "Decrease font size" })
vim.keymap.set({ 'n', 'i' }, "<C-ScrollWheelUp>", function() ResizeGuiFont(1) end,
    { noremap = true, silent = true, desc = "Increaser font size" })
vim.keymap.set({ 'n', 'i' }, "<C-ScrollWheelDown>", function() ResizeGuiFont(-1) end,
    { noremap = true, silent = true, desc = "Decrease font size" })
vim.keymap.set({ 'n', 'i' }, "<C-BS>", function() ResetGuiFont() end,
    { noremap = true, silent = true, desc = "Reset font size" })
