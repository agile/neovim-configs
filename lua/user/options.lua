vim.g.mapleader = ","

-- :help options
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.backup = false                          -- should a backup file be created?
vim.opt.swapfile = false                        -- should a swapfile be created?
vim.opt.undofile = false                         -- should a persistent undo file be created?
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.ignorecase = true                       -- should casing be ignored when searching (and replacing!)
-- vim.opt.smartcase = true                     -- don't ignore case with capitals

--  tab settings
vim.opt.expandtab = true                        -- should tab characters be replaced with spaces? (ctrl-v)
vim.opt.autoindent = true                       -- should lines be automatically indented
vim.opt.smartindent = true                      -- does the right thing (mostly) in programs
vim.opt.cindent = true                          -- stricter rules for C programs
vim.opt.tabstop = 2                             -- number of spaces a <Tab> counts for in file
vim.opt.shiftwidth = 2                          -- indenting is 2 spaces
vim.opt.softtabstop = 2                         -- number of space for tabbing while editing

-- ui-y sort of things..
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.showtabline = 1                         -- only show tabs if we're using them..
vim.opt.showmode = true                         -- should things like -- INSERT -- be displayed in the status bar?
vim.opt.cmdheight = 2                           -- more space in the neovim command line for displaying messages
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.splitbelow = false                      -- should horizontal splits to go below current window
vim.opt.splitright = false                      -- should vertical splits to go to the right of current window
vim.opt.cursorline = true                       -- should hte current line be highlighted
vim.opt.number = false                          -- should the (line) number column be displayed?
vim.opt.relativenumber = false                  -- should the number column show relative numbered lines?
vim.opt.numberwidth = 2                         -- set number column width to 2 {default 4}
vim.opt.signcolumn = "auto"                     -- when to show the sign col, yes:always, no:never, auto:when-needed, number:use-number col if present else auto
vim.opt.wrap = false                            -- should long lines wrap to the next line?
vim.opt.scrolloff = 8                           -- minimum lines of context to keep above/below cursor while scrolling
vim.opt.sidescrolloff = 8                       -- minimum columns of context to keep before/after cursor while side-scrolling
if vim.g.neovide then
  vim.g.neovide_cursor_trail_length = 0         -- disable ghosting effect on cursor
  vim.g.neovide_cursor_animation_length = 0     -- disable cursor animations
  vim.g.neovide_input_use_logo = true          -- mess with the super/cmd key?
end
vim.opt.shortmess:append "c"                    -- don't show ins-completion-menu msgs
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.hlsearch = false                        -- should search matches be highlighted?
vim.opt.foldenable = false                      -- should folds be enabled?

vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp

vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.updatetime = 300                        -- faster completion (4000ms default)


vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]                    -- treat hyphenated words as a complete word vs individual words between hyphens
vim.cmd [[set formatoptions-=cro]]              -- (remove c (auto-wrap), r (auto insert comment leader after hittin return, o (auto insert comment leader after hitting 'o')
