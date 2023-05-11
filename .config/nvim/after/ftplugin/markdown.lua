-- Definition of a Markdown link:
-- Link definition names may consist of letters, numbers, spaces, and
-- punctuation but they are not case sensitive. As per:
--      https://daringfireball.net/projects/markdown/syntax#link

-- TODO: Make it work if link is split over multiple lines, e.g. due to
-- linewrapping.
local _search = function(flags)
    if not flags then
        flags = ""
    end
    vim.fn.search("\\[.*\\](.\\{-})", flags)
end

local md_funcs = require("yannick.markdown")

vim.keymap.set("n", "<Tab>", _search, { desc="Go to next link" })
vim.keymap.set("n", "<S-Tab>", function() _search("b") end, { desc="Go to previous link" })
vim.keymap.set("n", "<CR>", md_funcs.go_next, { desc="Follow link under cursor" })
vim.keymap.set("n", "<BackSpace>", md_funcs.go_prev, { desc="Follow link under cursor" })
