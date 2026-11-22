-- Parsers and queries are installed by nvim-treesitter (main branch)
-- into ~/.local/share/nvim/site, which needs the tree-sitter CLI:
-- :TSInstall c gitignore hcl javascript lua markdown markdown_inline
--            python query rust sql typescript vim vimdoc vue
--
-- Incremental selection is built into Nvim 0.12: `an` / `in` in
-- visual mode (see :h treesitter-incremental-selection).

-- Start Tree-sitter highlighting for every filetype that has a parser,
-- whether installed by nvim-treesitter or bundled with Nvim. We check
-- for the parser first instead of wrapping start() in pcall, so query
-- errors (e.g. a parser that does not match its queries) still surface.
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if lang and vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf, lang)
    end
  end,
})

require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
  },
  move = {
    set_jumps = true,
  },
})

local select = require("nvim-treesitter-textobjects.select")
local move = require("nvim-treesitter-textobjects.move")

-- Selection
local select_objects = {
  ["ab"] = "@block.outer",
  ["ib"] = "@block.inner",
  ["af"] = "@function.outer",
  ["if"] = "@function.inner",
  ["ac"] = "@class.outer",
  ["ic"] = "@class.inner",
}

for key, query in pairs(select_objects) do
  vim.keymap.set({ "x", "o" }, key, function()
    select.select_textobject(query, "textobjects")
  end)
end

-- Movement
local movements = {
  ["]m"] = { "@function.outer", "next_start" },
  ["]M"] = { "@function.outer", "next_end" },
  ["[m"] = { "@function.outer", "previous_start" },
  ["[M"] = { "@function.outer", "previous_end" },
  ["]c"] = { "@class.outer", "next_start" },
  ["]C"] = { "@class.outer", "next_end" },
  ["[c"] = { "@class.outer", "previous_start" },
  ["[C"] = { "@class.outer", "previous_end" },
}

for key, config in pairs(movements) do
  local query, direction = config[1], config[2]

  vim.keymap.set({ "n", "x", "o" }, key, function()
    move["goto_" .. direction](query, "textobjects")
  end)
end
