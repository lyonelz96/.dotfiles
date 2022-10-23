local cmp_ok, cmp = pcall(require, 'cmp')
local luasnip_ok, luasnip = pcall(require, 'luasnip')
local lspkind_ok, lspkind = pcall(require, 'lspkind')

if cmp_ok and luasnip_ok and lspkind_ok then
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
		mapping = cmp.mapping.preset.insert({
			['<C-n>'] = cmp.mapping.select_next_item(),
			['<C-p>'] = cmp.mapping.select_prev_item(),
			['<C-l>'] = cmp.mapping(function()
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				end
			end, { 'i', 's' }),
			['<C-h>'] = cmp.mapping(function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				end
			end, { 'i', 's' }),
			['<C-j>'] = cmp.mapping.scroll_docs(4),
			['<C-k>'] = cmp.mapping.scroll_docs(-4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-x>'] = cmp.mapping.abort(),
			['<CR>'] = cmp.mapping.confirm({ select = false }),
		}),
		sources = {
			{ name = 'nvim_lua' },
			{ name = 'nvim_lsp' },
			{ name = 'path' },
			{ name = 'luasnip' },
			{ name = 'buffer' },
		},
		formatting = {
			format = lspkind.cmp_format({
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
		preselect = {
			cmp.PreselectMode.None,
		},
	})

	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'cmdline' },
		},
	})

	cmp.setup.cmdline('/', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' },
		},
	})

	local luasnip_vscode_ok, luasnip_vscode = pcall(require, 'luasnip.loaders.from_vscode')

	if luasnip_vscode_ok then
		luasnip_vscode.lazy_load()
	end

	vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
end
