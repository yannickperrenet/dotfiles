""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
" More on au[tocmd] can be found by typing :help autocmd

" The standard python.vim highlighting. vim/vim/runtime/syntax/python.vim
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

" Whenever you open a certain file regardless of whether it exist already
" or not, run a certain command.
" au BufNewFile,BufRead *.jinja set syntax=htmljinja
" au BufNewFile,BufRead *.mako set ft=mako

" Make lines starting with # behave similar to other lines. More info at:
" https://vim.fandom.com/wiki/Restoring_indent_after_typing_hash
au FileType python set cindent
au FileType python set cinkeys-=0#
au FileType python set indentkeys-=0#

" Use LSP omni-completion in Python files.
" au Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc


""""""""""""""""""""""""""""""
" => HTML section
""""""""""""""""""""""""""""""
" Improve readability
au FileType html setlocal sw=2 ts=2


""""""""""""""""""""""""""""""
" => Javascript section
""""""""""""""""""""""""""""""
" Improve readability
au FileType javascript setlocal sw=2 ts=2


""""""""""""""""""""""""""""""
" => hcl section
""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.hcl set filetype=hcl

" Improve readability
au FileType hcl setlocal sw=2 ts=2


""""""""""""""""""""""""""""""
" => Terraform section
""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.tf set filetype=terraform

" Improve readability
au FileType terraform setlocal sw=2 ts=2
