""""""""""""""""""""""""""""""
" => Colorscheme and Fonts
""""""""""""""""""""""""""""""
set background=dark
colorscheme peaksea


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['readonly', 'relativepath'],
      \             ['modified', 'fugitive'] ],
      \   'right': [ [ 'lineinfo' ], 
      \              ['percent'],
      \              ['fileencoding', 'filetype'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': '|', 'right': ' ' }
      \ }

let g:lightline.tab = {
	\ 'active': [ 'tabnum', 'filename', 'modified' ],
	\ 'inactive': [ 'tabnum', 'filename', 'modified' ] }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden = 0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize = 35
map <leader>nn :NERDTreeToggle<cr>


""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
" let g:bufExplorerDefaultHelp=0
" let g:bufExplorerShowRelativePath=1
" let g:bufExplorerFindActive=1
" let g:bufExplorerSortBy='name'
" map <leader>o :BufExplorer<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimwiki
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Register a vimwiki different from the default
let g:vimwiki_list = [{'path': '~/Google\ Drive/vimwiki/', 
    \ 'path_html': '~/Google\ Drive/vimwiki/vimwiki-html/',
    \ 'template_path': '~/Google\ Drive/vimwiki/vimwiki-styling/',
    \ 'template_default': 'default',
    \ 'template_ext': '.html',
    \ 'auto_export': 0,
    \ 'nested_syntaxes': {'python': 'python'}}]

" Parse open vimwiki to html 
nmap <leader>wc <Plug>Vimwiki2HTML
" Parse the entire vimwiki
nmap <leader>wC <Plug>VimwikiAll2HTML


""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0

let g:ctrlp_map = '<c-f>'
let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee\|^\venv'

" Customize the mappings inside the CtrlP's prompt
let g:ctrlp_pompt_mappings = {
    \ 'PrtCleakCache()':      ['<F5>']
    \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ack searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use the the_silver_searcher if possible (much faster than Ack)
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif

" Highlight the search term in the results
let g:ackhighlight = 1

" Options --color and --group disable the function to follow links,
" which is obvisouly undesired
let g:ack_default_options = " -s -H --nogroup --ignore-dir=venv"

let g:ack_qhandler = "botright copen 10"

" Without this option the shortcuts, e.g. open in split, won't work
let g:ack_apply_qmappings = 1

" Every time you type :Ack it actually becomes :Ack! which does not
" follow the first result from the search.
cnoreabbrev Ack Ack!


""""""""""""""""""""""""""""""
" => YankStack
""""""""""""""""""""""""""""""
let g:yankstack_yank_keys = ['y', 'd']

nmap <c-p> <Plug>yankstack_substitute_older_paste
nmap <c-n> <Plug>yankstack_substitute_newer_paste
