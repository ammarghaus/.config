local home = vim.fn.expand("~/zettelkasten")
require('telekasten').setup({ home = home })

vim.api.nvim_set_keymap('n', '<leader>tk', ':Telekasten<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>to', ':Telekasten goto_today<CR>', { noremap = true, silent = true })
