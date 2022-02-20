" Highlight the search term in the results
let g:ackhighlight = 1

let g:ack_autofold_results = 1

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
