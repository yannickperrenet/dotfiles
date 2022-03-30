" Make <Tab> go to the next markdown link.
nnoremap <buffer> <Tab> :call search('\[.*\]\(.*\)')<cr>
nnoremap <buffer> <S-Tab> :call search('\[.*\]\(.*\)', 'b')<cr>
