require("dap-python").setup("debugpy-adapter")

-- local dap = require("dap-python")
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)

-- Be sure to first call dap.continue() to start your debuggin session!
-- :help dap-mappings
-- :help dap-api
local dap = require("dap")
vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dv', function() require("dap-view").toggle() end)
vim.keymap.set('n', '<Leader>dc', function() dap.continue() end)
vim.keymap.set('n', '<Up>', function() dap.continue() end)
vim.keymap.set('n', '<Right>', function() dap.step_into() end)
vim.keymap.set('n', '<Left>', function() dap.step_out() end)
vim.keymap.set('n', '<Down>', function() dap.step_over() end)