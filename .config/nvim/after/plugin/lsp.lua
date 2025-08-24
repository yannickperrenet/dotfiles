-- :LspInfo
--
-- Configure a new Language Server:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- Get the floating windows to stand out!
vim.o.winborder = "bold"


-- Not ready to be used yet: https://github.com/astral-sh/ty
-- Completion doesn't work whatsoever.
--
-- vim.lsp.config("ty", {
--     init_options = {
--         settings = {
--             experimental = {
--                 completions = { enable = true }
--             },
--         },
--     }
-- })

vim.lsp.enable({ "pyright", "rust_analyzer" })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true
    }
)

local opts = { noremap=true, silent=true }

function get_lsp_references(opts)
    if pcall(require, 'telescope') then
        return require('telescope.builtin').lsp_references(opts)
    else
        return vim.lsp.buf.references(opts)
    end
end

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>d', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'gr', get_lsp_references, opts)
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)


function show_and_select(cmp)
    if not cmp.is_visible() then
        cmp.show()
    end
    return cmp.select_next()
end

local blink = require("blink.cmp")
local disabled_ftypes = { }
blink.setup({
    enabled = function() return not vim.tbl_contains(disabled_ftypes, vim.bo.filetype) end,

    keymap = {
        preset = 'default',
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'insert_prev', 'fallback' },
      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
      ['<C-n>'] = { show_and_select },
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    completion = {
        list = {
            max_items = 20,
            selection = {
                -- Don't select an item from the menu automatically.
                preselect = false,
                -- Insert when selecting an item from the menu
                auto_insert = true
            }
        },

        -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/
        -- Computing documentation is expensive, so only do it on items
        -- in the menu that are selected long enough.
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 150,
            window = {
                max_width = 100,
                -- Put menu above current line, because putting it to the east
                -- will likely cause unnecessary linewrapping.
                direction_priority = {
                    menu_north = { 'n', 's', 'e', 'w' },
                    menu_south = { 'n', 's', 'e', 'w' },
                },
            }
        },

        -- Display a preview of the selected item on the current line
        ghost_text = { enabled = false },

        menu = {
          -- Don't automatically show the completion menu
          auto_show = false,

          -- nvim-cmp style menu
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              -- If you don't yet have a font on your system that
              -- renders icons, you can choose to download a Nerd Font:
              -- https://www.nerdfonts.com/font-downloads
              -- Next, you unzip the directory and place the .ttf files in:
              -- ~/.local/share/fonts/
              -- If the font is not found yet, run: `fc-cache -f -v`
              -- and restart your terminal so it uses the new font.
              { "kind_icon", "kind", gap = 1 },
              { "source_name" }
            },
          },


        },
    },

    signature = { enabled = true },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    --
    -- Inside the blink.cmp directory run: `cargo build --release` to get
    -- Rust performance.
    fuzzy = { implementation = "prefer_rust_with_warning" },

    -- https://github.com/microsoft/pyright/blob/c8fafd81141e8f787bb727bb1244888bc86b04c9/packages/pyright-internal/src/languageServerBase.ts#L602
    -- config = function()
    --     local capabilities = {
    --         completionProvider = { triggerCharacters = {"."} },
    --     }
    --     capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
    --     local lspconfig = require('lspconfig')

    --     lspconfig['pyright'].setup({ capabilities = capabilities })
    --   end
})

-- vim.lsp.completion.enable(true, 1, 0, {autotrigger=true})
