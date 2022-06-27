require('which-key').setup({})

require('which-key').register({
	d = { name = 'Diagnostic' },
}, { prefix = '<leader>' })

require('which-key').register({
	['<leader>'] = {
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
			l = 'LSP',
			['lt'] = 'Type',
			['lw'] = 'Workspace',
		},
		w = { name = 'Window' },
	},
})
