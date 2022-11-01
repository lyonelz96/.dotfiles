local mason_ok, mason = pcall(require, 'mason')

if mason_ok then
	mason.setup({})

	local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'homey.mason.lspconfig')
	if mason_lspconfig_ok then
		mason_lspconfig.setup()
	end

	local mason_null_ls_ok, mason_null_ls = pcall(require, 'homey.mason.null_ls')
	if mason_null_ls_ok then
		mason_null_ls.setup()
	end
end
