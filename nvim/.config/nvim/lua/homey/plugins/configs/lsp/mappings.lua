local M = {}

M.set_lsp_mappings = function(bufnr)
	local nmap = function(keys, func, desc)
		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

	nmap('<leader>lgd', vim.lsp.buf.definition, '[L]SP [G]oto [D]efinition')
	nmap('<leader>lgi', vim.lsp.buf.implementation, '[L]SP [G]oto [I]mplementation')
	nmap('<leader>lh', vim.lsp.buf.hover, '[L]SP [H]over')
	nmap('<leader>lsh', vim.lsp.buf.signature_help, '[L]SP [S]ignature [H]elp')
	nmap('<leader>lrn', vim.lsp.buf.rename, '[L]SP [R]e[N]ame')
	nmap('<leader>lca', vim.lsp.buf.code_action, '[L]SP [C]ode [A]ction')
	nmap('<leader>lf', vim.lsp.buf.formatting, '[L]SP [F]ormat')

	nmap('<leader>tlr', require('telescope.builtin').lsp_references, '[T]elescope [L]SP [R]eferences')
	nmap('<leader>tlsd', require('telescope.builtin').lsp_document_symbols, '[T]elescope [L]SP [S]ymbols [D]ocument ')
	nmap('<leader>tli', require('telescope.builtin').lsp_implementations, '[T]elescope [L]SP [I]mplementations')
	nmap('<leader>tld', require('telescope.builtin').lsp_definitions, '[T]elescope [L]SP [D]efinitions')
	nmap('<leader>tltd', require('telescope.builtin').lsp_type_definitions, '[T]elescope [L]SP [T]ype [D]efinitions')
	nmap(
		'<leader>tlsw',
		require('telescope.builtin').lsp_dynamic_workspace_symbols,
		'[T]elescope [L]SP [S]ymbols [W]orkspace'
	)

	require('which-key').register({
		l = {
			name = 'LSP',
			c = { name = 'Code Action' },
			g = { name = 'Goto' },
			r = { name = 'Rename' },
			s = { name = 'Signature' },
		},
		t = {
			name = 'Telescope',
			l = {
				name = 'LSP',
				t = { name = 'Type' },
				s = { name = 'Symbols' },
			},
		},
	}, { prefix = '<leader>', buffer = bufnr, mode = 'n' })
end

return M
