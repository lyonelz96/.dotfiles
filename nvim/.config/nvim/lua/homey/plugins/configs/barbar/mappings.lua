vim.keymap.set('n', '<leader>bh', '<Cmd>BufferPrevious<CR>')
vim.keymap.set('n', '<leader>bl', '<Cmd>BufferNext<CR>')
vim.keymap.set('n', '<leader>bp', '<Cmd>BufferPick<CR>')
vim.keymap.set('n', '<leader>bcc', '<Cmd>BufferClose<CR>')
vim.keymap.set('n', '<leader>bch', '<Cmd>BufferCloseBuffersLeft<CR>')
vim.keymap.set('n', '<leader>bcl', '<Cmd>BufferCloseBuffersRight<CR>')
vim.keymap.set('n', '<leader>bca', '<Cmd>BufferCloseAllButCurrent<CR>')

require('which-key').register({
	b = {
		name = 'BarBar',
		c = { name = 'BufferCloseOpts' },
	},
}, { prefix = '<leader>', mode = 'n' })
