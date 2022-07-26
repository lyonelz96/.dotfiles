local on_attach = function(_, bufnr)
	require('homey.plugins.configs.lsp.mappings').set_lsp_mappings(bufnr)
	require('lsp_signature').on_attach()
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

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

require('lspconfig').jsonls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require('lspconfig').bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
