local null_ls = require('null-ls')

local eruby_beautifier = {
	name = 'eruby-beautifier',
	filetypes = { 'eruby' },
	method = null_ls.methods.FORMATTING,
	generator = require('null-ls.helpers').formatter_factory({
		command = 'htmlbeautifier',
		args = { '--keep-blank-lines', '1' },
		to_stdin = true,
	}),
}

null_ls.setup({
	sources = {
		eruby_beautifier,
		null_ls.builtins.formatting.stylua.with({
			extra_args = { '--quote-style', 'ForceSingle' },
		}),
		null_ls.builtins.diagnostics.eslint_d.with({
			only_local = 'node_modules/.bin',
		}),
		null_ls.builtins.formatting.prettierd.with({
			only_local = 'node_modules/.bin',
		}),
	},
})
