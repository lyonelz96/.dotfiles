local on_attach = function(_, bufnr)
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
	nmap('<leader>tlds', require('telescope.builtin').lsp_document_symbols, '[T]elescope [L]SP [D]ocument [S]ymbols')
	nmap('<leader>tli', require('telescope.builtin').lsp_implementations, '[T]elescope [L]SP [I]mplementations')
	nmap('<leader>tld', require('telescope.builtin').lsp_definitions, '[T]elescope [L]SP [D]efinitions')
	nmap('<leader>tltd', require('telescope.builtin').lsp_type_definitions, '[T]elescope [L]SP [T]ype [D]efinitions')
	nmap(
		'<leader>tlws',
		require('telescope.builtin').lsp_dynamic_workspace_symbols,
		'[T]elescope [L]SP [W]orkspace [S]ymbols'
	)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('nvim-lsp-installer').setup({})

require('lspconfig').emmet_ls.setup({
	capabilities = capabilities,
	filetypes = { 'html', 'css', 'eruby' },
	on_attach = on_attach,
})

require('lspconfig').html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require('lspconfig').solargraph.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require('lspconfig').sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' },
			},
			format = {
				enable = true,
				defaultConfig = {
					quote_style = 'single',
				},
			},
		},
	},
})

require('lspconfig').tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require('lspconfig').rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
