require('mason').setup({})
require('mason-lspconfig').setup({})

local on_attach = function(_, bufnr)
	require('homey.plugins.configs.lsp.mappings').set_lsp_mappings(bufnr)
	require('lsp_signature').on_attach()
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('mason-lspconfig').setup_handlers({
	-- default handler
	function(server_name)
		require('lspconfig')[server_name].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,
	-- overrides
	['sumneko_lua'] = function()
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
	end,
	['emmet_ls'] = function()
		require('lspconfig').emmet_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { 'html', 'css', 'eruby' },
		})
	end,
})
