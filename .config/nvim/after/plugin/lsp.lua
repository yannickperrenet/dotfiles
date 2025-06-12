-- :LspInfo
--
-- Configure a new Language Server:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- Get the floating windows to stand out!
vim.o.winborder = "bold"

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


local has_words_before = function()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    if col == 0 then
        return false
    end
    local line = vim.api.nvim_get_current_line()
    return line:sub(col, col):match("%s") == nil
end

-- Inside the blink.cmp directory run: `cargo build --release` to get
-- Rust performance.
local blink = require("blink.cmp")
local disabled_ftypes = { "markdown" }
blink.setup({
		enabled = function() return not vim.tbl_contains(disabled_ftypes, vim.bo.filetype) end,

    keymap = {
        preset = 'default',
        ['<Tab>'] = {
            function(cmp)
                if has_words_before() then
                    return cmp.insert_next()
                end
            end,
            'fallback',
        },
      -- Navigate to the previous suggestion or cancel completion if currently on the first one.
      ['<S-Tab>'] = { 'insert_prev' },
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    completion = {
        list = {
            selection = {
                -- Don't select an item from the menu automatically.
                preselect = false,
                -- Insert when selecting an item from the menu
                auto_insert = true
            }
        },

        documentation = { auto_show = true, auto_show_delay_ms = 500 },

        -- Display a preview of the selected item on the current line
        ghost_text = { enabled = true },

        menu = {
          -- Don't automatically show the completion menu
          auto_show = true,

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

						-- cursorline_priority = 20000,
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
    fuzzy = { implementation = "prefer_rust_with_warning" },
})

