" Key (re)Mappings

" copy and paste short-cuts
imap <C-V> <ESC>"+pA
vmap <C-C> "+y
" map Q to something useful
noremap Q gq
" make Y consistent with C and D
nnoremap Y y$

" vim-test mappings
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" Make visual selection copy to PRIMARY_CLIPBOARD
" re: https://github.com/neovim/neovim/issues/2325#issuecomment-209288070
vmap <LeftRelease> "*ygv
