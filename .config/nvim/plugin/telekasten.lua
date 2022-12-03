local home = vim.fn.expand("~/zettelkasten")
require('telekasten').setup({ home = home })

vim.api.nvim_set_keymap('n', '<leader>tk', ':Telekasten<CR>', { noremap = true, silent = true })
