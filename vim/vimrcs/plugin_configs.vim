""""""""""""""""""""""""""""""
" => Colorscheme and Fonts
""""""""""""""""""""""""""""""
set background=dark
colorscheme peaksea

" OMG, without this the signcolumn is displayed as DarkGreen
" ... so ugly
highlight SignColumn ctermfg=none ctermbg=none


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ale
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install https://github.com/palantir/python-language-server
" into your virtualenv to use this, and requires to start vim
" at the root of your project.
call ale#linter#Define('python-lsp', {
  \   'name': 'pyls',
  \   'lsp': 'stdio',
  \   'executable': '$VIRTUAL_ENV/bin/pyls',
  \   'command': '%e run',
  \   'project_root': getcwd()
  \})

" Python
" - flake8: pep8 check
" - pyls: use the language server defined above (name is pyls)
" - mypy: enable linting for type checking on annotated files
let g:ale_linters = {
\   'javascript': ['jshint'],
\   'python': ['flake8', 'pyls', 'mypy'],
\   'go': ['go', 'golint', 'errcheck']
\}

nmap <silent> <leader>a <Plug>(ale_next_wrap)
nmap <leader>gd <Plug>(ale_go_to_definition)
nmap <leader>fr <Plug>(ale_find_references)

let g:ale_set_highlights = 1
let g:ale_completion_enabled = 1

let g:ale_python_pyls_executable = 'pyls'

" Linting
let g:ale_lint_on_text_changed = 'never'

" flake8 configurations.
" See: https://flake8.pycqa.org/en/latest/user/options.html
" Some configuration options have been introduced at a later
" version and thus need to be disabled for lower version.
" Otherwise ale does not work in its entirety for python.
let g:flake8_version = system('echo $(flake8 --version | grep -o "^\S*" | tr -d ".")')
if g:flake8_version < 379
    let g:ale_python_flake8_options = '--max-line-length=88'
else
    let g:ale_python_flake8_options = '--max-line-length=88 --max-doc-length=74'
endif

" Otherwise the linting might trigger and 'de-trigger' the 
" signcolumn 24/7, making the screen go from left to right
" to left to right to left....
let g:ale_sign_column_always = 1


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
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/', 
    \ 'path_html': '~/Documents/vimwiki/vimwiki-html/',
    \ 'template_path': '~/Documents/vimwiki/vimwiki-styling/',
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


""""""""""""""""""""""""""""""
" => comfortable motion
""""""""""""""""""""""""""""""
" Otherwise the <C-f> will overwrite the CtrlP mapping
let g:comfortable_motion_no_default_key_mappings = 1

nnoremap <silent> <C-d> :call comfortable_motion#flick(100)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(-100)<CR>
