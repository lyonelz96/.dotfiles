local treesitter_ok, treesitter = pcall(require, 'nvim-treesitter.configs')

if treesitter_ok then
	treesitter.setup({
		ensure_installed = { 'lua', 'comment' },
		highlight = { enable = true },
	})
end
