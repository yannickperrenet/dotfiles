" :W --> sudo saves the file. Useful for permission-denied errors.
command W w !sudo tee % > /dev/null

" Return to last edit position when opening files (You want this!)
" When starting to edit an existing file (any filetype), do:
" - line("'\"") gets the line number of the cursor position when last
"   exiting the current buffer.
"   - 'x get position of mark x
"   - \" means the mark " which is the cursor position when last exiting
"     the current buffer
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
