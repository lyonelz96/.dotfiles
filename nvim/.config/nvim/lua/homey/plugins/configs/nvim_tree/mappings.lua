vim.keymap.set('n', '<leader>nvt', '<Cmd>NvimTreeToggle<CR>')

require('which-key').register({
	n = {
		name = 'NvimTree',
		v = { name = 'Toggle' },
	},
}, { prefix = '<leader>', mode = 'n' })
