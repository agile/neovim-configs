call plug#begin('~/.local/share/nvim/plugged')

" Interact with test runners from vim
Plug 'janko-m/vim-test'
" annotate indentations
" Plug 'Yggdroot/indentLine'
" align the things
Plug 'godlygeek/tabular'
" show what changed (when committing)
Plug 'ghewgill/vim-scmdiff'
" color themes
Plug 'rafi/awesome-vim-colorschemes'
" git
Plug 'tpope/vim-fugitive'

" linter/lsp-client
" disabled until/unless I configure it to avoid conflicting with what coc.nvim is doing..
" eg: coc.nvim pop-up sometimes comes up with useful info but gets closed almost
" immediately becuase ALE linter errors as I'm typing
" Plug 'w0rp/ale'
"
" render color codes
Plug 'ap/vim-css-color'
" Navigator
Plug 'scrooloose/nerdtree'
" Statusbar whizbanger
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Jinja2 syntax
Plug 'Glench/Vim-Jinja2-Syntax'

" gutter signs for vcs changes
" Plug 'mhinz/vim-signify'
" let g:signify_vcs_list = [ 'git' ]


" LSP client
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
" go-lang
Plug 'fatih/vim-go' ", { 'tag': '*' }
" rust
Plug 'rust-lang/rust.vim'
" scala
Plug 'derekwyatt/vim-scala'
" typesafe config
Plug 'GEVerding/vim-hocon'

" Initialize plugin system
call plug#end()


