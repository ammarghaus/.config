local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader>g', ':G log<CR>', opts)
map('n', '<leader>gl', ':G log %<CR>', opts)
map('n', '<leader>gs', '::G<CR>', opts)
map('n', '<leader>gd', ':G diff %<CR>', opts)
map('n', '<leader>gb', ':GBrowse<CR>', opts)
map('n', '<leader>gw', ':Gwrite<CR>', opts)
map('n', '<leader>gr', ':Gread<CR>', opts)
map('n', '<leader>gc', ':G commit<CR>', opts)
map('n', '<leader>gz', ':G stash<CR>', opts)
map('n', '<leader>gzp', ':G stash pop<CR>', opts)
map('n', '<leader>ge', ':G commit --amend --no-edit<CR>', opts)
map('n', '<leader>gp', ':G pull --rebase<CR>', opts)
map('n', '<leader>gP', ':G push<CR>', opts)
map('n', '<leader>gPf', ':G push --force-with-lease<CR>', opts)
map('n', '<leader>pr', ':silent !hub pr show<CR>:redraw!<CR>', opts)
map('n', '<leader>ci', ':sp term://hub ci-status -v<CR>', opts)

