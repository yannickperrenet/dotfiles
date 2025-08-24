local flash = require("flash")

flash.setup{
	labels = "dfjksluieghocnzqp",
	search = {
		multi_window = true,
	},
	modes = {
		char = {
			enabled = false,
		},
	},
	jump = {
		-- No clue which keystroke would trigger the jump as you just type
		-- some chars instead of waiting after each char to see what happens
		-- in flash.
		autojump = false,
	},
	label = {
		uppercase = false,
		style = "inline",
	}
}


vim.keymap.set('n', '<leader>j', flash.jump, {desc="[J]ump"})
