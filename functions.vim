" Various Functions/autocommands

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal g`\""
        endif
    end
endfunction
autocmd BufReadPost * call SetCursorPosition()

" http://vimcasts.org/episodes/tidying-whitespace/
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" when would I NOT want to strip trailing whitespace?
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
" autocmd BufWritePre *.md,*.markdown,*.sql,*.sh,*.scala,*.sbt,*.go,*.py,*.js,*pp,*.c,*.cc,*.h,*.rb,*.y*ml :call <SID>StripTrailingWhitespaces()

" invoke tab completion when hitting tab, unless we're in the indentation zone..
function! CleverTab()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<Tab>"
   else
      return "\<C-N>"
   endif
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>

" Open NERDTree if we're given a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

function! SwitchTheme(theme)
  colorschema theme
  if theme == "brookstream"
    let g:airline_theme='alduin'
  else
    let g:airline_theme='default'
  endif
endfunction

" open diff of index in vsplit if editing git commit msg
autocmd BufReadPost COMMIT_EDITMSG
  \ exe "vnew" |
  \ exe "set bt=nofile ft=diff" |
  \ exe "silent r! git diff --cached" |
  \ exe "normal gg" |
  \ exe "normal :wincmd w" |
  \ exe "normal ggi"

" open diff of index in vsplit if editing svn commit msg
autocmd BufReadPost svn-commit*.tmp
  \ exe "vnew" |
  \ exe "set bt=nofile ft=diff" |
  \ exe "silent r! svn diff" |
  \ exe "normal gg" |
  \ exe "normal :wincmd w" |
  \ exe "normal ggi"

