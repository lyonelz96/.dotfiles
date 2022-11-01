local M = {}

M.setup = function()
	local null_ls_ok, null_ls = pcall(require, 'null-ls')
	local mason_null_ls_ok, mason_null_ls = pcall(require, 'mason-null-ls')

	if null_ls_ok and mason_null_ls_ok then
		mason_null_ls.setup({
			ensure_installed = { 'stylua', 'prettierd', 'eslint_d' },
		})

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

return M
