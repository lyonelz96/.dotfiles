local setup_mason_lspconfig = function()
	local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
	local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')

	if lspconfig_ok and mason_lspconfig_ok then
		mason_lspconfig.setup({})

		local on_attach = function(_, bufnr)
			require('homey.keymap.lsp').set_lsp_keymaps(bufnr)
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()

		local cmp_lsp_ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')

		if cmp_lsp_ok then
			capabilities = cmp_lsp.default_capabilities()
		end

		mason_lspconfig.setup_handlers({
			-- default handler
			function(server_name)
				lspconfig[server_name].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			-- overrides
			['sumneko_lua'] = function()
				lspconfig.sumneko_lua.setup({
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
									trailing_table_separator = 'smart',
								},
							},
						},
					},
				})
			end,
			['emmet_ls'] = function()
				lspconfig.emmet_ls.setup({
					on_attach = on_attach,
					capabilities = capabilities,
					filetypes = { 'html', 'css', 'eruby' },
				})
			end,
		})
	end
end

local setup_mason_null_ls = function()
	local null_ls_ok, null_ls = pcall(require, 'null-ls')
	local mason_null_ls_ok, mason_null_ls = pcall(require, 'mason-null-ls')

	if null_ls_ok and mason_null_ls_ok then
		mason_null_ls.setup({})

		mason_null_ls.setup_handlers({
			stylua = function()
				null_ls.register(null_ls.builtins.formatting.stylua.with({
					extra_args = { '--quote-style', 'ForceSingle' },
				}))
			end,
			prettierd = function()
				null_ls.register(null_ls.builtins.formatting.prettierd.with({
					only_local = 'node_modules/.bin',
				}))
			end,
			eslint_d = function()
				null_ls.register(null_ls.builtins.diagnostics.eslint_d.with({
					only_local = 'node_modules/.bin',
				}))
			end,
		})

		null_ls.setup({})
	end
end

local mason_ok, mason = pcall(require, 'mason')

if mason_ok then
	mason.setup({})
	setup_mason_lspconfig()
	setup_mason_null_ls()
end
