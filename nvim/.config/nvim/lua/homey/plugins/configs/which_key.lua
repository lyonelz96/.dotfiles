local wk = require('which-key')

wk.setup({})

wk.register({
	d = { name = 'Diagnostic' },
	b = {
		name = 'BarBar',
		c = { name = 'BufferCloseOpts' },
	},
	c = { name = 'Comment' },
	n = {
		name = 'NvimTree',
		v = { name = 'Toggle' },
	},
	t = {
		name = 'Telescope',
		b = { name = 'Buffer' },
		f = { name = 'Find' },
		g = { name = 'Grep' },
	},
	w = { name = 'Window' },
}, { prefix = '<leader>', mode = 'n' })

wk.register({
	c = { name = 'Comment' },
}, { prefix = '<leader>', mode = 'v' })
