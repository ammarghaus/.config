vim.opt.number          =  true
vim.opt.cursorline      =  true
vim.opt.relativenumber  =  true
vim.opt.numberwidth     =  1
vim.opt.splitright      =  true
vim.opt.splitbelow      =  true
vim.opt.hidden          =  false
vim.opt.wildmenu        =  true
vim.opt.wildmode        =  'longest:full'
vim.opt.textwidth       =  120
vim.opt.colorcolumn     =  '+1'
vim.opt.so              =  999

vim.api.nvim_set_hl(0, 'linenr', { ctermfg = 'DarkGrey' })
vim.api.nvim_set_hl(0, 'signcolumn', { link = 'linenr' })
vim.api.nvim_set_hl(0, 'NormalFloat', {})

vim.api.nvim_set_hl(0, 'colorcolumn', { ctermbg = 'DarkGrey' })
vim.api.nvim_set_hl(0, 'CursorLine', { ctermfg = 'Yellow' })
vim.api.nvim_set_hl(0, 'DiffAdd', { ctermbg = 'DarkGrey' })
vim.api.nvim_set_hl(0, 'DiffText', { ctermbg = 'Brown' })
vim.api.nvim_set_hl(0, 'DiffChange', { ctermbg = 'DarkGrey' })

require('lspconfig.ui.windows').default_options.border = 'single'
vim.api.nvim_set_hl(0, 'LspInfoBorder', { ctermfg = 'Green' })
vim.api.nvim_set_hl(0, 'FloatBorder', { ctermbg=None })
