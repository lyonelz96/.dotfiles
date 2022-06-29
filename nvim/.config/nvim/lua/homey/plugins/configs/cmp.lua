local cmp = require('cmp')

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = {
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-x>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({ select = false }),
	},
	sources = {
		{ name = 'nvim_lua' },
		{ name = 'nvim_lsp' },
		{ name = 'path' },
		{ name = 'luasnip' },
		{ name = 'buffer' },
	},
	formatting = {
		format = require('lspkind').cmp_format({
			with_text = true,
			menu = {
				buffer = '[buf]',
				nvim_lsp = '[LSP]',
				nvim_lua = '[api]',
				path = '[path]',
				luasnip = '[snip]',
			},
		}),
	},
	experimental = {
		ghost_text = true,
	},
})

require('luasnip.loaders.from_vscode').lazy_load()
