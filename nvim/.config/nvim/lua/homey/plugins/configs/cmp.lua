local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = {
		['<C-n>'] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			end
		end),
		['<C-p>'] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-x>'] = cmp.mapping.abort(),
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
