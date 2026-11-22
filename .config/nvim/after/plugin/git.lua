local signs = require("gitsigns")
signs.setup({
    current_line_blame_formatter = '<author> • <summary>',
    current_line_blame_opts = {
        delay = 150,
    },
    signcolumn = false,
    linehl = true,
    numhl = true,
})
-- Great to see all changes in the repo and then use :cnext to go through
-- all of them quickly.
vim.keymap.set(
    "n",
    "<Leader>gha",
    function()
        signs.setqflist("all")
    end,
    { desc = "[G]it [H]unks [A]ll to Qflist" }
)
vim.keymap.set(
    "n",
    "<Leader>gh",
    function()
        signs.setqflist()
    end,
    { desc = "[G]it [H]unks to Qflist" }
)
vim.keymap.set(
    'n',
    '<Leader>gb',
    '<cmd>Gitsigns toggle_current_line_blame<CR>',
    { desc = "[G]it [B]lame" }
)
-- Inside this blame window, when you are on a commit, you can then
-- use `s` and `S` to open the commit in a split and tab respectively.
-- Pretty usefull to quickly check out the the whole commit.
vim.keymap.set(
    "n",
    "<Leader>gbb",
    function()
        signs.blame()
    end,
    { desc = "[G]it [B]ig [B]lame" }
)

-- First do <Leader>gbb and then move cursor on the commit, then use
-- this mapping to see the full diff over all files. It is an extension
-- on top of the native gitsigns `S` mapping.
vim.keymap.set(
    "n",
    "<Leader>df",
    function()
        local word = vim.fn.expand("<cword>")
        local sha = word:match("%x%x%x%x%x%x%x+")

        if sha then
            vim.cmd("DiffviewOpen " .. sha .. "^!")
        end
    end,
    { desc = "[D]iffview [F]ull" }
)

-- Jump to next and previous hunks in diffview.
vim.keymap.set(
    "n", "]h", function()
        if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
        else
            signs.nav_hunk("next")
        end
    end,
    { desc = "[C]hange [N]ext" }
)
vim.keymap.set(
    "n", "[h", function()
        if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
        else
            signs.nav_hunk("prev")
        end
    end,
    { desc = "[C]hange [P]revious" }
)

-- Keep the diffview pair in sync when an LSP jump (or <C-o>) loads
-- another file into the right-hand window.
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("DiffviewFollow", { clear = true }),
    callback = function(args)
        -- LSP sets the cursor after swapping the buffer, so wait
        -- until the jump has finished before reading it.
        vim.schedule(function()
            local view = require("diffview.lib").get_current_view()
            if not (view and view.set_file_by_path and view.cur_layout) then
                return
            end
            local win = vim.api.nvim_get_current_win()
            if view.cur_layout:get_main_win().id ~= win
                or vim.api.nvim_win_get_buf(win) ~= args.buf
            then
                return
            end
            local abs = vim.api.nvim_buf_get_name(args.buf)
            if abs == "" or abs:match("^diffview://") then
                return
            end
            local rel = vim.fs.relpath(view.adapter.ctx.toplevel, abs)
            if not rel or (view.cur_entry and view.cur_entry.path == rel) then
                return
            end
            for _, file in view.files:iter() do
                if file.path == rel then
                    view.cursor_map[rel] = vim.fn.winsaveview()
                    view:set_file_by_path(rel, true, true)
                    return
                end
            end
        end)
    end,
})
