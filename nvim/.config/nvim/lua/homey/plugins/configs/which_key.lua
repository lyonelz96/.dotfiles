require('which-key').setup({})

require('which-key').register({
	d = { name = 'Diagnostic' },
	b = { name = 'BarBar', c = 'BufferCloseOpts' },
	g = { name = 'Comment' },
	l = { name = 'LSP', c = 'Code Action', g = 'Goto', r = 'Rename', s = 'Signature' },
	n = { name = 'NvimTree', v = 'Toggle' },
	t = {
		name = 'Telescope',
		b = 'Buffer',
		f = 'Find',
		g = 'Grep',
		l = {
			name = 'LSP',
			t = 'Type',
			w = 'Workspace',
			d = 'Document',
		},
	},
	w = { name = 'Window' },
}, { prefix = '<leader>' })
