let g:completion_matching_strategy_list = ['exact', 'substring']

let g:completion_chain_complete_list = {
    \'default' : [
    \    {'complete_items': ['lsp']},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'}
    \]
    \}

let g:completion_trigger_character = ['.']
let g:completion_trigger_keyword_length = 2

" Otherwise matches starting with '_' will be first in the completion
" list, whilst they are often the matches you want.
let g:completion_sorting = 'none'
