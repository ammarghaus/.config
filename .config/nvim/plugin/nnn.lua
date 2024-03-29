local builtin = require("nnn").builtin

require("nnn").setup( {
	mappings = {
		{ "<C-t>", builtin.open_in_tab },       -- open file(s) in tab
		{ "<C-x>", builtin.open_in_split },     -- open file(s) in split
		{ "<C-v>", builtin.open_in_vsplit },    -- open file(s) in vertical split
		{ "<C-p>", builtin.open_in_preview },   -- open file in preview split keeping nnn focused
		{ "<C-y>", builtin.copy_to_clipboard }, -- copy file(s) to clipboard
		{ "<C-e>", builtin.populate_cmdline },  -- populate cmdline (:) with file(s)
	},
	picker = { style = { width = 0.25, height = 0.5, border = "single" } }
}
)

vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>NnnPicker %:p:h<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>NnnPicker<cr>', { noremap = true, silent = true })
