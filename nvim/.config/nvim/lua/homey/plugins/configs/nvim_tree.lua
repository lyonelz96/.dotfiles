require('nvim-tree').setup({
	diagnostics = {
		enable = true,
	},
})

vim.keymap.set('n', '<leader>nvt', '<Cmd>NvimTreeToggle<CR>')
