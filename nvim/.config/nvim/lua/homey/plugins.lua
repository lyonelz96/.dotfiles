local packer_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system({
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		packer_path,
	})

	vim.cmd([[packadd packer.nvim]])
end

local packer_ok, packer = pcall(require, 'packer')

if packer_ok then
	packer.startup(function(use)
		-- looks
		use('rebelot/kanagawa.nvim')
		use('nvim-lualine/lualine.nvim')
		use('kyazdani42/nvim-web-devicons')
		use('onsails/lspkind-nvim')
		use('stevearc/dressing.nvim')
		use('akinsho/bufferline.nvim')

		-- lsp
		use('neovim/nvim-lspconfig')
		use('hrsh7th/nvim-cmp')
		use('hrsh7th/cmp-buffer')
		use('hrsh7th/cmp-path')
		use('hrsh7th/cmp-cmdline')
		use('hrsh7th/cmp-nvim-lsp')
		use('hrsh7th/cmp-nvim-lua')
		use('saadparwaiz1/cmp_luasnip')
		use('L3MON4D3/LuaSnip')
		use('rafamadriz/friendly-snippets')
		use('williamboman/mason.nvim')
		use('williamboman/mason-lspconfig.nvim')
		use('jayp0521/mason-null-ls.nvim')
		use('jose-elias-alvarez/null-ls.nvim')

		-- nav
		use('nvim-lua/plenary.nvim')
		use('nvim-telescope/telescope.nvim')
		use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
		use('kyazdani42/nvim-tree.lua')
		use('ggandor/lightspeed.nvim')

		-- qol
		use('kosayoda/nvim-lightbulb')
		use('antoinemadec/FixCursorHold.nvim')
		use('windwp/nvim-autopairs')
		use('folke/which-key.nvim')
		use('numToStr/Comment.nvim')
		use('wbthomason/packer.nvim')
		use({
			'nvim-treesitter/nvim-treesitter',
			run = function()
				require('nvim-treesitter.install').update({ with_sync = true })
			end,
		})
		use('nvim-treesitter/nvim-treesitter-context')

		-- misc
		use('ThePrimeagen/vim-be-good')

		if PACKER_BOOTSTRAP then
			require('packer').sync()
		end
	end)
end

if PACKER_BOOTSTRAP then
	print('==================================')
	print('    Plugins are being installed')
	print('    Wait until Packer completes,')
	print('       then restart nvim')
	print('==================================')
	return
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })

vim.api.nvim_create_autocmd('BufWritePost', {
	command = 'source <afile> | PackerSync',
	group = packer_group,
	pattern = 'plugins.lua',
})
