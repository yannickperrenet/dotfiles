local function qf_toggle()
    local qfbufnr = vim.fn.getqflist({ qfbufnr = 0 }).qfbufnr
    -- Whether the qf buffer is open in a window
    local has_win
    if qfbufnr == 0 then -- Quickfix buffer doesn't exist
        has_win = false
    else                 -- Quickfix buffer has been open before
        if #vim.fn.win_findbuf(qfbufnr) > 0 then
            has_win = true
        else
            has_win = false
        end
    end

    if has_win then
        -- If we are currently on the qf window, then first switch
        -- back to the previous window
        if vim.fn.bufnr("%") == qfbufnr then
            vim.cmd.wincmd("p")
        end
        vim.cmd.cclose()
    else
        vim.cmd("botright copen")
    end
end

vim.keymap.set("n", "<C-q>", qf_toggle, { desc = "Toggle qf window" })


local function zettelkasten_new()
    print("Don't forget to save the Zettel!")

    -- todo: make vimwiki path into global const
    local target_path = "~/protondrive/vimwiki/docs/zettelkasten/"
    local ts = vim.fn.localtime()
    vim.cmd.edit(target_path .. ts .. ".md")
end

vim.keymap.set("n", "<leader>zn", zettelkasten_new, { desc = "[Z]ettelkasten [N]ew" })
