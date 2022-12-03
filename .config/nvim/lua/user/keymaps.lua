local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader>vt', ':vsp term://fish<CR>', opts)
map('n', '<leader>st', ':sp term://fish<CR>', opts)
map('n', '<leader>ct', ':term<CR>', opts)
map('n', '<leader>w', ':w | e<CR>', opts)
map('n', '<leader>wq', ':wq<CR>', opts)
map('n', '<leader>q', ':q<CR>', opts)
map('n', '<leader>qa', ':qa<CR>', opts)
map('n', '<leader>Q', ':q!<CR>', opts)
map('n', '<leader>Qa', ':qa!<CR>', opts)
map('n', '<leader>E', ':e!<CR>', opts)
map('n', '<leader>sd', ':w<CR> :bd<CR>', opts)
map('n', '<leader>d', ':bd<CR>', opts)
map('n', '<leader>D', ':bd!<CR>', opts)
map('n', '<leader>n', ':noh<CR>', opts)

map('n', '<leader>bi', 'obinding.pry<Esc> :update<CR>', opts)
map('n', '<leader>bI', 'Obinding.pry<Esc> :update<CR>', opts)
map('n', '<leader>bu', ':sp term://bundle<CR>', opts)
map('n', '<leader>rs', ':sp term://rails c<CR>', opts)
map('n', '<leader>rr', ':silent !touch tmp/restart.txt<CR>', opts)
