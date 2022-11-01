local M = {}

local function default_handler(server_name)
	local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
	if lspconfig_ok then
		local on_attach = function(_, bufnr)
			require('homey.keymap.lsp').set_lsp_keymaps(bufnr)
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()

		local cmp_lsp_ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
		if cmp_lsp_ok then
			capabilities = cmp_lsp.default_capabilities()
		end

		local config = {
			on_attach = on_attach,
			capabilities = capabilities,
		}

		local settings_ok, settings = pcall(require, 'homey.mason.lspconfig.servers.' .. server_name)

		if settings_ok then
			config = vim.tbl_deep_extend('force', config, settings)
		end

		lspconfig[server_name].setup(config)
	end
end

M.setup = function()
	local lspconfig_ok, _ = pcall(require, 'lspconfig')
	local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')

	if lspconfig_ok and mason_lspconfig_ok then
		mason_lspconfig.setup({
			ensure_installed = { 'sumneko_lua', 'tsserver' },
		})

		mason_lspconfig.setup_handlers({ default_handler })
	end
end

return M
