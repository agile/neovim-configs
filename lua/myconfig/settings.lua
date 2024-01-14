-- :help options
local options = {
    fileencoding = "utf-8",    -- the encoding written to a file
    autoread = true,           -- auto-re-read file if buffer's unmodified and file's altered outside of vim
    wrap = false,              -- should long lines be wrapped?
    backup = false,            -- should backup files be created?
    swapfile = false,          -- should swap files be created?
    hidden = true,             -- should buffers be kept around if window closed?
    undofile = false,          -- should a persistent undo file be created?
    undodir = "/tmp/.nvimdid", -- location of persistent undo file

    ignorecase = true,         -- should casing be ignored when searching (and replacing!)
    -- smartcase = true,        -- don't ignore case with capitals
    hlsearch = true,           -- should search matches be highlighted?
    incsearch = true,          -- should matches be made as a pattern is typed?
    showmode = false,          -- should the current mode be shown in status bar?
    showtabline = 1,           -- should tabline be shown? 0:never, 1:w/1+ tabs, 2: always

    autoindent = true,         -- should lines be automatically indented
    smartindent = true,        -- does the right thing (mostly) in programs
    cindent = true,            -- stricter rules for C programs?
    breakindent = true,        -- maintain indentation when wrapping?
    expandtab = true,          -- should tabs be expanded to spaces?
    tabstop = 2,               -- how many characters represent a <Tab>
    softtabstop = 2,           -- number of space for tabbing while editing
    shiftwidth = 2,            -- how many characters to indent
    shiftround = true,         -- should indention be rounded to multiples of shiftwidth?
    splitbelow = false,        -- should h-splits put new window below current?
    splitright = false,        -- should v-splits put new window to right of current?

    scrolloff = 5,             -- minimum lines of context to keep above/below cursor while scrolling
    sidescrolloff = 5,         -- minimum columns of context to keep before/after cursor while side-scrolling
    number = true,             -- should the (line) number column be displayed?
    relativenumber = true,     -- should the number column show relative numbered lines?
    numberwidth = 2,           -- min cols to use for line number. (default 4)
    signcolumn = "auto",       -- when to show the sign col, yes:always, no:never, auto:when-needed, number:use-number col if present else auto
    -- colorcolumn = "80",      -- highlight this column?
    termguicolors = true,      -- set term gui colors (most terminals support this)
    background = "dark",       -- adjust default color groups for background type: dark vs light
    completeopt = {            -- insert-mode completion
        "menuone",             -- popup menu even w/only 1 option
        "noselect",            -- don't autoselect options
        "noinsert",            -- Do not insert any test for a match until a selection is made
    },
    diffopt = {
        "internal",            -- use internal xdiff lib
        "algorithm:histogram", -- myers (default), minimal, patience, histogram
        "indent-heuristic",    -- Use the indent heuristic le
        "linematch:60",        -- perform secondary diff on hunks under 60 lines
    },

    -- clipboard = "unnamedplus", --allows neovim access to the system clipboard
    cursorline = true,  -- should the current line be highlighted
    mouse = "a",        -- allow mouse to be used in neovim in all modes
    cmdheight = 2,      -- number of screen lines to use for the command-line.
    pumheight = 10,     -- max number of lines to show in popup menu
    laststatus = 3,     -- should last window have status line? 0:never, 1:only w/2+ wins, 2:always, 3:always, ONLY last window
    updatetime = 50,    -- milliseconds idle before writing swapfile, also used for CursorHold autocommand event(completions) (default 4000)
    timeoutlen = 1000,  -- Time in milliseconds to wait for a mapped sequence to complete.

    foldenable = false, -- should folds be enabled?
    foldmethod = "expr",
    foldexpr = "nvim_treesitter#foldexpr()",
    foldlevelstart = 99, -- always start with no folds closed (99), all folds closed (0), some folds closed (1)
    foldlevel = 99,

    conceallevel = 0, -- so that `` is visible in markdown files
}

for key, value in pairs(options) do
    vim.opt[key] = value
end

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

if vim.g.neovide then
    vim.g.neovide_cursor_trail_length = 0     -- disable ghosting effect on cursor
    vim.g.neovide_cursor_animation_length = 0 -- disable cursor animations
    vim.g.neovide_input_use_logo = true       -- mess with the super/cmd key?
    -- vim.g.neovide_transparency = 0.95          -- slightly transparent..
    -- vim.g.neovide_underline_stroke_scale = 100
end
vim.g.python3_host_prog = "~/.pyenv/versions/neovim_3.8.13/bin/python"
vim.g.ruby_host_prog = "~/.rbenv/versions/3.1.2/bin/neovim-ruby-host"

vim.opt.shortmess:append "c"          -- don't show ins-completion-menu msgs
vim.opt.shortmess:remove "F"          -- allow file info to be shown when editing a file (https://github.com/scalameta/nvim-metals#user-content-fn-shortmess-93d16b9f1b9fd41fbf9d9580a948d581)

vim.opt.isfname:append("@-@")         -- allow filenames to also include the @ char

vim.cmd [[set fcs=eob:\ ]]            -- attempt to disable ~ displayed for empty lines at end of buffer?
vim.cmd [[filetype plugin indent on]] -- turn on filetype, plugin, and indent
vim.cmd "set whichwrap+=<,>,[,],h,l"  -- which keys can move cursor to next/prev line when wrapping (default b, s)
vim.cmd [[set iskeyword+=-]]          -- treat hyphenated words as a complete word vs individual words between hyphens
vim.cmd [[set formatoptions-=cro]]    -- (remove c (auto-wrap), r (auto insert comment leader after hittin return, o (auto insert comment leader after hitting 'o')

-- local utils = require "utils"
-- utils.set_indent_sizes { go = 4, python = 4, rust = 4, cpp = 4, c = 4, make = 4, lua = 4, java = 4, json = 4 }

-- nvim-notify as default vim notification method
local _notify, notify = pcall(require, "notify")
if _notify then
    vim.notify = notify
end

-- https://github.com/jalvesaq/Nvim-R/issues/668
-- let R_assign = 2
vim.g.R_assign_map = '<M-->'
