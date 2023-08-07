local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)
end


require('lspconfig').solargraph.setup { on_attach = on_attach }
require('lspconfig').lua_ls.setup { on_attach = on_attach }

require'lspconfig'.lua_ls.setup{}

map('n', '<leader>l', ':lua vim.diagnostic.disable()<CR>', opts)
map('n', '<leader>ll', ':lua vim.diagnostic.enable()<CR>', opts)
