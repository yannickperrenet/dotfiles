" When inside a git repository, make sure to stage deleted files as
" otherwise they will be included in the files.
let g:ctrlp_user_command = {
\ 'types': {
  \ 1: ['.git', 'git ls-files -co --exclude-standard'],
  \ },
\ 'fallback': 'fdfind --hidden --type file --ignore-file=.gitignore 2>/dev/null'
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

nnoremap <C-b> :CtrlPBuffer<CR>
nnoremap <C-f> :CtrlP<CR>

" Ask for another character after <C-o> to specify how to open
" the marked (with <C-z>) files.
let g:ctrlp_arg_map = 1

let g:ctrlp_show_hidden = 1
let g:ctrlp_cache_dir = $XDG_CACHE_HOME.'/ctrlp'
