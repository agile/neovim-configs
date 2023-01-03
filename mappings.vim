" Various Functions/autocommands

" "jump to last cursor position when opening a file
" "dont do it when writing a commit log entry
" function! SetCursorPosition()
"     if &filetype !~ 'commit\c'
"         if line("'\"") > 0 && line("'\"") <= line("$")
"             exe "normal g`\""
"         endif
"     end
" endfunction
" autocmd BufReadPost * call SetCursorPosition()

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

