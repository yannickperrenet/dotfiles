" Register a vimwiki different from the default
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/',
    \ 'path_html': '~/Documents/vimwiki/vimwiki-html/',
    \ 'template_path': '~/Documents/vimwiki/vimwiki-styling/',
    \ 'template_default': 'default',
    \ 'template_ext': '.html',
    \ 'auto_export': 0,
    \ 'nested_syntaxes': {'python': 'python'},
    \ 'automatic_nested_syntaxes': 1}]

" Parse open vimwiki to html
nmap <leader>wc <Plug>Vimwiki2HTML
" Parse the entire vimwiki
nmap <leader>wC <Plug>VimwikiAll2HTML
