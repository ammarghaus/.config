local augroup = vim.api.nvim_create_augroup('user_cmds', {clear = true})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = {'*'},
  group = augroup,
  desc = 'Remove trailing blanks.',
  command = [[%s/\s\+$//e]]
})

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = {'*'},
  group = augroup,
  desc = 'Start terminal in insert mode.',
  command = [[startinsert]]
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  desc = 'Highlight yanked text.',
  callback = function(event)
    vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
  end
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = {'packer_bootstrap.lua', 'plugin/*.lua'},
  group = augroup,
  desc = 'Compile plugins loader bootstrap file changed.',
  command = [[source <afile> | PackerCompile]]
})

vim.api.nvim_create_autocmd('User', {
  pattern = {'FugitiveEditor'},
  group = augroup,
  desc = 'Set spell in fugitive commit message buffer.',
  command = 'set spell'
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = {'*'},
  group = augroup,
  desc = 'Disable diagnostics by default.',
  command = 'lua vim.diagnostic.disable()'
})

