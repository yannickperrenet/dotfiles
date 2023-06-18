local M = {}

M._stack = {}

M.go_next = function()
    local line = vim.fn.getline('.')
    -- \{-} means non-greedy match as to stop on first )
    local result = vim.fn.matchlist(line, "\\[.*\\](\\(.\\{-}\\))")
    if #result == 0 then
        return
    end

    -- 1 is the full match and 2 is the submatch indicated by \(\)
    local link = result[2]
    if string.match(link, "^http[s]://") then
        -- :!xdg-open 'https://example.org'
        vim.fn.execute("!" .. vim.api.nvim_get_var("netrw_browsex_viewer") .. " '" .. link .. "'")
    else
        table.insert(M._stack, vim.fn.expand("%"))
        vim.fn.execute("e " .. vim.fn.expand("%:p:h") .. "/" .. link)
    end
end

M.go_prev = function()
    if #M._stack == 0 then
        return
    end

    local prev_file = table.remove(M._stack)
    vim.fn.execute("e " .. prev_file)
end
--
-- TODO: Make it work if link is split over multiple lines, e.g. due to
-- linewrapping.
M.search = function(flags)
    if not flags then
        flags = ""
    end
    vim.fn.search("\\[.*\\](.\\{-})", flags)
end

return M
