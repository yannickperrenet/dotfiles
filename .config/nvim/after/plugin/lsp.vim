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
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  -- Completion.
  local nvim_completion = require('completion')
  nvim_completion.on_attach(client, bufnr)
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = { "pyright", "tsserver", "rust_analyzer" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { settings = settings[lsp], on_attach = on_attach }
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true
    }
)

EOF
