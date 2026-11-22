-- https://codecompanion.olimorris.dev/configuration/adapters-acp
require("codecompanion").setup({
  interactions = {
    chat = {
      adapter = "claude_code", -- Or "codex", "gemini_cli", "opencode" and more
      keymaps = {
        send = {
          modes = { n = "<CR>", i = {} },
        },
      },
    },
  },
  prompt_library = {
    markdown = {
      dirs = {
        vim.fn.stdpath("config") .. "/codecompanion-prompts",
      },
    },
  },
  display = {
    chat = {
      window = {
        -- layout = "buffer",   -- open in the current window instead
        layout = "tab",
        buflisted = true,    -- show it in :ls and bufferlines
      },
    },
  },
})

local function explain_more()
  local codecompanion = require("codecompanion")
  local chat = codecompanion.last_chat()
  if not chat then
    return codecompanion.prompt("explain")
  end
  codecompanion.add()
  chat.prompt:add({
    content = "Explain this code too. Same instructions as before.",
  })
  chat:submit()
end

vim.keymap.set("v", "<Leader>ae", explain_more, {
  desc = "[A]I [E]xplain code",
})

vim.keymap.set("n", "<Leader>ao", "<cmd>CodeCompanionChat Toggle<cr>", {
  desc = "[A]I [O]pen",
})

vim.keymap.set("v", "<Leader>ac", function()
  require("codecompanion").add()
end, { desc = "[A]I [C]omment on code" })
