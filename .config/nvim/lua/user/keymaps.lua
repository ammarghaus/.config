local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader>w', ':w<CR>', opts)
map('n', '<leader>wq', ':wq<CR>', opts)
map('n', '<leader>q', ':q<CR>', opts)
map('n', '<leader>qa', ':qa<CR>', opts)
map('n', '<leader>Q', ':q!<CR>', opts)
map('n', '<leader>Qa', ':qa!<CR>', opts)
map('n', '<leader>tq', ':tabclose<CR>', opts)
map('n', '<leader>E', ':e!<CR>', opts)
map('n', '<leader>sd', ':w<CR> :bd<CR>', opts)
map('n', '<leader>d', ':bd<CR>', opts)
map('n', '<leader>D', ':bd!<CR>', opts)
map('n', '<leader>n', ':noh<CR>', opts)

map('n', '<leader>ub', ':g/binding.pry/ d<CR> :update<CR>', opts)
map('n', '<leader>bi', 'obinding.pry<Esc> :update<CR>', opts)
map('n', '<leader>bI', 'Obinding.pry<Esc> :update<CR>', opts)
map('n', '<leader>bu', ':TermExec cmd="bundle"<CR>', opts)
map('n', '<leader>rs', ':TermExec cmd="rails c" go_back=0<CR>', opts)
map('n', '<leader>rr', ':silent !touch tmp/restart.txt<CR>', opts)

map('i', '<C-l>', "<C-R>=system('next_pr_link')[0:-2]<CR>", opts)
map('i', '<C-d>', "<C-R>=system('next_pr_nu')[0:-2]<CR>", opts)
