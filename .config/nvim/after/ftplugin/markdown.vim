" Definition of a Markdown link:
" Link definition names may consist of letters, numbers, spaces, and
" punctuation - but they are not case sensitive.
" -- as per https://daringfireball.net/projects/markdown/syntax#link

" TODO: Make it work if link is split over multiple lines, e.g. due to
" linewrapping.
" Make <Tab> go to the next markdown link.
nnoremap <buffer> <Tab> :call search('\[.*\](.\{-})')<cr>
nnoremap <buffer> <S-Tab> :call search('\[.*\](.*)', 'b')<cr>

nnoremap <buffer> <CR> :call FollowMDLink()<cr>
