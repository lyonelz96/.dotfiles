vim.keymap.set('n', '<leader>bch', '<Cmd>BufferLineCloseLeft<CR>')
vim.keymap.set('n', '<leader>bcl', '<Cmd>BufferLineCloseRight<CR>')
vim.keymap.set('n', '<leader>bh', '<Cmd>BufferLineCyclePrev<CR>')
vim.keymap.set('n', '<leader>bl', '<Cmd>BufferLineCycleNext<CR>')
vim.keymap.set('n', '<leader>bp', '<Cmd>BufferLinePick<CR>')
vim.keymap.set('n', '<leader>bcp', '<Cmd>BufferLinePickClose<CR>')

require('which-key').register({
	b = {
		name = 'BufferLine',
		c = { name = 'BufferCloseOpts' },
	},
}, { prefix = '<leader>', mode = 'n' })
