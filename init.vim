let mapleader = ","
let g:python_host_prog = '~/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '~/.pyenv/versions/neovim3/bin/python'

" not using ale anymore..
" " ALE config
" let g:ale_set_baloons = 1
" " Tell airline to enable ALE info
" let g:airline#extensions#ale#enabled = 1
" let g:ale_open_list = 1

source ~/.config/nvim/plugins.vim
source ~/.config/nvim/coc-settings.vim
source ~/.config/nvim/functions.vim
source ~/.config/nvim/mappings.vim

" disable line wrapping
set nowrap
" disable line numbers
set nonumber
" disable highlighting search matches (I prefer to enable if/when I want that, usually I don't)
set nohls
" enable mouse everywhere
set mouse=a
" ignore casing when searching (and replacing!)
set ignorecase
" tab settings
set expandtab     " don't use actual tab character (ctrl-v)
set autoindent    " turns it on
set smartindent   " does the right thing (mostly) in programs
set cindent       " stricter rules for C programs
set tabstop=2     " number of spaces a <Tab> counts for in file
set shiftwidth=2  " indenting is 2 spaces
set softtabstop=2 " number of space for tabbing while editing

" Theme settings..
set termguicolors     " enable true colors support
" colorscheme challenger_deep
colorscheme brookstream
" Status line settings..
" let g:airline_statusline_ontop=1
let g:airline_theme='alduin'

" IndentLine settings (indention characters)
" let g:indentLine_char = ''
" let g:indentLine_first_char = ''
" let g:indentLine_showFirstIndentLevel = 1
" let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

