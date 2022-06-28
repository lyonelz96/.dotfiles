require('which-key').setup({})

require('which-key').register({
	d = { name = 'Diagnostic' },
	b = {
		name = 'BarBar',
		c = { name = 'BufferCloseOpts' },
	},
	g = { name = 'Comment' },
	l = {
		name = 'LSP',
		c = { name = 'Code Action' },
		g = { name = 'Goto' },
		r = { name = 'Rename' },
		s = { name = 'Signature' },
	},
	n = {
		name = 'NvimTree',
		v = { name = 'Toggle' },
	},
	t = {
		name = 'Telescope',
		b = { name = 'Buffer' },
		f = { name = 'Find' },
		g = { name = 'Grep' },
		l = {
			name = 'LSP',
			t = { name = 'Type' },
			w = { name = 'Workspace' },
			d = { name = 'Document' },
		},
	},
	w = { name = 'Window' },
}, { prefix = '<leader>' })
