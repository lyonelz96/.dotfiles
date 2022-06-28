local on_attach = function(_, bufnr)
	require('homey.plugins.configs.lsp.mappings')(bufnr)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('nvim-lsp-installer').setup({})

require('lspconfig').emmet_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { 'html', 'css', 'eruby' },
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
