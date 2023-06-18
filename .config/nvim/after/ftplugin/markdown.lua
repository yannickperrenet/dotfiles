-- Definition of a Markdown link:
-- Link definition names may consist of letters, numbers, spaces, and
-- punctuation but they are not case sensitive. As per:
--      https://daringfireball.net/projects/markdown/syntax#link


local md_funcs = require("yannick.markdown")

vim.keymap.set("n", "<Tab>", md_funcs.search, { desc="Go to next link" })
vim.keymap.set("n", "<S-Tab>", function() md_funcs.search("b") end, { desc="Go to previous link" })
vim.keymap.set("n", "<CR>", md_funcs.go_next, { desc="Follow link under cursor" })
vim.keymap.set("n", "<BackSpace>", md_funcs.go_prev, { desc="Follow link under cursor" })
