""""""""""""""""""""""""""""""
" => Colorscheme and Fonts
""""""""""""""""""""""""""""""
set background=dark
colorscheme peaksea

" OMG, without this the signcolumn is displayed as DarkGreen
" ... so ugly
highlight SignColumn ctermfg=none ctermbg=none


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
" When inside a git repository, make sure to stage deleted files as
" otherwise they will be included in the files.
let g:ctrlp_user_command = {
\ 'types': {
  \ 1: ['.git', 'git ls-files -co --exclude-standard'],
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

nnoremap <C-b> :CtrlPBuffer<CR>

" Ask for another character after <C-o> to specify how to open
" the marked (with <C-z>) files.
let g:ctrlp_arg_map = 1

let g:ctrlp_show_hidden = 1
let g:ctrlp_cache_dir = $XDG_CACHE_HOME.'/ctrlp'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ack searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ripgrep is the fastest of them all and does not have gitignore issues
if executable('rg')
  let g:ackprg = 'rg --vimgrep --smart-case'
elseif executable('ag')
    " Use the the_silver_searcher if possible (much faster than Ack)
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
" => easymotion
""""""""""""""""""""""""""""""
" One mapping to rule them all! Jump to any word, anywhere.
nmap <leader>j <Plug>(easymotion-overwin-w)


""""""""""""""""""""""""""""""
" => completion-nvim
""""""""""""""""""""""""""""""
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


""""""""""""""""""""""""""""""
" => LSP
""""""""""""""""""""""""""""""
" :LspInfo
"
" Configure a new Language Server:
" https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
"
" pyright:
" * pyrightconfig.json
" * https://github.com/microsoft/pyright/blob/master/docs/configuration.md

lua << EOF
local nvim_lsp = require('lspconfig')

-- Setup defaults
local settings = {
  pyright = { }
}

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  -- Completion.
  local nvim_completion = require('completion')
  nvim_completion.on_attach(client, bufnr)
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = { "pyright", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { settings = settings[lsp], on_attach = on_attach }
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true
    }
)

EOF
