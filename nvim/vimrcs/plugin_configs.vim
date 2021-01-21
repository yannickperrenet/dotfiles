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
" Searches upward to the file to get the virtualenv. Does not
" require you to have the virtualenv set, but will fall back to
" $VIRTUAL_ENV if it cannot find it. Make sure you have installed
" `python-language-server` into the environment.
function! GetPylsExecutable(buffer) abort
    return ale_linters#python#FindVirtualenv(a:buffer) . '/bin/pyls'
endfunction

" Overwrites the build in 'pyls' because that requires using
" `pipenv`.
call ale#linter#Define('python-lsp', {
\   'name': 'pyls',
\   'lsp': 'stdio',
\   'executable': function('GetPylsExecutable'),
\   'command': '%e run',
\   'project_root': function('ale#python#FindProjectRoot'),
\   'completion_filter': 'ale#completion#python#CompletionItemFilter',
\   'lsp_config': {b -> ale#Var(b, 'python_pyls_config')},
\})

let g:ale_linters = {
\   'javascript': ['jshint'],
\   'python': ['flake8', 'pyls', 'mypy'],
\   'rust': ['analyzer', 'rls']
\}

" Linter configurations.
" * flake8
"   See: https://flake8.pycqa.org/en/latest/user/options.html
"   Some configuration options have been introduced at a later
"   version and thus need to be disabled for lower version.
"   Otherwise ale does not work in its entirety for python.
let g:flake8_version = system('echo $(flake8 --version | grep -o "^\S*" | tr -d ".")')
if g:flake8_version < 379
    let g:ale_python_flake8_options = '--max-line-length=88'
else
    let g:ale_python_flake8_options = '--max-line-length=88 --max-doc-length=72'
endif

" * mypy
let g:ale_python_mypy_options = '--allow-redefinition'


nmap <silent> <leader>a <Plug>(ale_next_wrap)
nmap <leader>gd <Plug>(ale_go_to_definition)
nmap <leader>fr <Plug>(ale_find_references)

" Show documentation of function under cursor.
nmap <leader>sd <Plug>(ale_hover)

let g:ale_set_highlights = 1
let g:ale_completion_enabled = 1

" Linting
let g:ale_lint_on_text_changed = 'never'

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
" let g:NERDTreeWinPos = "right"
" let NERDTreeShowHidden = 0
" let NERDTreeIgnore = ['\.pyc$', '__pycache__']
" let g:NERDTreeWinSize = 35
" map <leader>nn :NERDTreeToggle<cr>


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
    \ 'nested_syntaxes': {'python': 'python'},
    \ 'automatic_nested_syntaxes': 1}]

" Parse open vimwiki to html
nmap <leader>wc <Plug>Vimwiki2HTML
" Parse the entire vimwiki
nmap <leader>wC <Plug>VimwikiAll2HTML


""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_user_command = {
\ 'types': {
  \ 1: ['.git', 'git ls-files -co'],
  \ },
\ 'fallback': 'fdfind --type file'
\ }

let g:ctrlp_working_path_mode = 0

let g:ctrlp_map = '<c-f>'
let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git
            \^\.coffee\|^\venv\|^\.mypy_cache\|^\.egg-info'

" Customize the mappings inside the CtrlP's prompt
" let g:ctrlp_pompt_mappings = {
"     \ 'PrtClearCache()':      ['<F5>'],
"     \ }

let g:ctrlp_extensions = ['buffertag']
" map <leader>t :CtrlPBufTag<cr>

" Flags and arguments to `ctags`
let g:ctrlp_buftag_types = {
\ 'python': '--format=2 --fields=fKst',
\ }

" Ask for another character after <C-o> to specify how to open
" the marked (with <C-z>) files.
let g:ctrlp_arg_map = 1

let g:ctrlp_show_hidden = 1
let g:ctrlp_cache_dir = $XDG_CACHE_HOME.'/ctrlp'


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
let g:ack_default_options = ' -s -H --nogroup
                    \ --ignore-dir={venv,.egg-info,.mypy_cache}'

let g:ack_qhandler = "botright copen 10"

" Without this option the shortcuts, e.g. open in split, won't work
let g:ack_apply_qmappings = 1

" Every time you type :Ack it actually becomes :Ack! which does not
" follow the first result from the search.
" cnoreabbrev Ack Ack!

" :help key-notation
map <leader>f :Ack!<Space>


""""""""""""""""""""""""""""""
" => YankStack
""""""""""""""""""""""""""""""
let g:yankstack_yank_keys = ['y', 'd', 'c']

nmap <c-p> <Plug>yankstack_substitute_older_paste
nmap <c-n> <Plug>yankstack_substitute_newer_paste


""""""""""""""""""""""""""""""
" => comfortable motion
""""""""""""""""""""""""""""""
" Otherwise the <C-f> will overwrite the CtrlP mapping
let g:comfortable_motion_no_default_key_mappings = 1

nnoremap <silent> <C-d> :call comfortable_motion#flick(100)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(-100)<CR>

""""""""""""""""""""""""""""""
" => rust.vim
""""""""""""""""""""""""""""""
" Automatically run :RustFmt on save of buffer
let g:rustfmt_autosave = 1
