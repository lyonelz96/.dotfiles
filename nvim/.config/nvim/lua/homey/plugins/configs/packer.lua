local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		install_path,
	})
end

require('packer').startup(function(use)
	--- LOOKS ---
	use('eddyekofo94/gruvbox-flat.nvim')
	use('rebelot/kanagawa.nvim')
	use('nvim-lualine/lualine.nvim')
	use('kyazdani42/nvim-web-devicons')
	use('onsails/lspkind-nvim')
	use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
	use('nvim-treesitter/nvim-treesitter-context')
	use('stevearc/dressing.nvim')
	use('romgrk/barbar.nvim')

	--- LSP ---
	use('neovim/nvim-lspconfig')
	use('hrsh7th/nvim-cmp')
	use('hrsh7th/cmp-buffer')
	use('hrsh7th/cmp-path')
	use('hrsh7th/cmp-nvim-lsp')
	use('hrsh7th/cmp-nvim-lua')
	use('saadparwaiz1/cmp_luasnip')
	use('L3MON4D3/LuaSnip')
	use('rafamadriz/friendly-snippets')
	use('williamboman/mason.nvim')
	use('williamboman/mason-lspconfig.nvim')
	use('jose-elias-alvarez/null-ls.nvim')

	--- NAVIGATION ---
	use('nvim-lua/plenary.nvim')
	use('nvim-telescope/telescope.nvim')
	use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
	use('kyazdani42/nvim-tree.lua')
	use('ggandor/lightspeed.nvim')

	--- MISC ---
	use('kosayoda/nvim-lightbulb')
	use('windwp/nvim-autopairs')
	use('folke/which-key.nvim')
	use('numToStr/Comment.nvim')
	use('wbthomason/packer.nvim')

	if packer_bootstrap then
		require('packer').sync()
	end
end)

if packer_bootstrap then
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
	pattern = 'packer.lua',
})
