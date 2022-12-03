vim.g["test#strategy"] = "neovim"
vim.g["test#neovim#term_position"] = "botright 30"

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader>tn', ':TestNearest<CR>', opts)
map('n', '<leader>tf', ':TestFile<CR>', opts)
map('n', '<leader>tl', ':TestLast<CR>', opts)
map('n', '<leader>tw', '<C-w>o:TestLast<CR>', opts)
map('n', '<leader>tg', ':TestVisit<CR>', opts)

vim.api.nvim_set_keymap('n', '<leader>r', '', {
	noremap = true,
	silent = true,
	callback = (function()
		vim.cmd('lcd ' .. vim.fn.system('pathfinder ' ..
			vim.fn.expand('%:p:h') .. " Gemfile | head -n 1 | awk -F/Gemfile '{print $1}'"))
	end)
})

vim.api.nvim_set_keymap('n', '<leader>R', '', {
	noremap = true,
	silent = true,
	callback = (function()
		vim.cmd('lcd ..')
	end)
})
