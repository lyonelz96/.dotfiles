local null_ls = require('null-ls')

require('mason-null-ls').setup({})

require('mason-null-ls').setup_handlers({
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
