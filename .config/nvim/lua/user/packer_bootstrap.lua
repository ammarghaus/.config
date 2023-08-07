local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'airblade/vim-gitgutter'
	use 'tpope/vim-abolish'
	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'
	use 'tpope/vim-unimpaired'
	use 'tpope/vim-endwise'
	use 'tpope/vim-eunuch'
	use 'tpope/vim-fugitive'
	use 'tpope/vim-rhubarb'
	use 'tpope/vim-dadbod'
	use 'kristijanhusak/vim-dadbod-ui'
	use 'luukvbaal/nnn.nvim'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-telescope/telescope-fzf-native.nvim'
	use 'nvim-telescope/telescope-file-browser.nvim'
	use 'LukasPietzschmann/telescope-tabs'
	use 'neovim/nvim-lspconfig'

	use {
		'pwntester/octo.nvim',
		requires = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope.nvim',
			'kyazdani42/nvim-web-devicons',
		},
		config = function()
			require "octo".setup()
		end
	}

	use 'kdheepak/lazygit.nvim'

	use { "akinsho/toggleterm.nvim", tag = '*', config = function()
		require("toggleterm").setup()
	end }

	use 'uga-rosa/translate.nvim'

	use 'junegunn/goyo.vim'
	use 'vim-test/vim-test'
	use 'renerocksai/telekasten.nvim'

	use 'dag/vim-fish'
	use 'nelsyeung/twig.vim'
	use 'AndrewRadev/splitjoin.vim'
	use 'gpanders/editorconfig.nvim'

	if packer_bootstrap then
		require('packer').sync()
	end
end)
