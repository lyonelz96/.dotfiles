local M = {}

M.set_lsp_mappings = function(bufnr)
	local nmap = function(keys, func, desc)
		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

	local imap = function(keys, func, desc)
		vim.keymap.set('i', keys, func, { buffer = bufnr, desc = desc })
	end

	local lsp_formatting = function()
		local function on_choice(choice)
			if choice == nil then
				return nil
			end

			print('Formatted with: ' .. choice.name)
			vim.lsp.buf.format({ bufnr = bufnr, name = choice.name })
		end

		local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
		local clients_with_formatting = vim.tbl_filter(function(client)
			return client['server_capabilities']['documentFormattingProvider']
		end, clients)

		table.sort(clients_with_formatting, function(a, b)
			return a.name < b.name
		end)

		if #clients_with_formatting > 1 then
			vim.ui.select(clients_with_formatting, {
				prompt = 'Select a language server:',
				format_item = function(client)
					return client.name
				end,
			}, on_choice)
		elseif #clients_with_formatting < 1 then
			print('No clients with formatting capabilities attached')
			on_choice(nil)
		else
			on_choice(clients_with_formatting[1])
		end
	end

	nmap('<leader>lgd', vim.lsp.buf.definition, '[L]SP [G]oto [D]efinition')
	nmap('<leader>lgi', vim.lsp.buf.implementation, '[L]SP [G]oto [I]mplementation')
	nmap('<leader>lh', vim.lsp.buf.hover, '[L]SP [H]over')
	nmap('<leader>lsh', vim.lsp.buf.signature_help, '[L]SP [S]ignature [H]elp')
	imap('<C-s>', vim.lsp.buf.signature_help, '[L]SP [S]ignature [H]elp')
	nmap('<leader>lrn', vim.lsp.buf.rename, '[L]SP [R]e[N]ame')
	nmap('<leader>lca', vim.lsp.buf.code_action, '[L]SP [C]ode [A]ction')
	nmap('<leader>lf', lsp_formatting, '[L]SP [F]ormat')

	nmap('<leader>tlr', require('telescope.builtin').lsp_references, '[T]elescope [L]SP [R]eferences')
	nmap('<leader>tlsd', require('telescope.builtin').lsp_document_symbols, '[T]elescope [L]SP [S]ymbols [D]ocument ')
	nmap('<leader>tli', require('telescope.builtin').lsp_implementations, '[T]elescope [L]SP [I]mplementations')
	nmap('<leader>tld', require('telescope.builtin').lsp_definitions, '[T]elescope [L]SP [D]efinitions')
	nmap('<leader>tltd', require('telescope.builtin').lsp_type_definitions, '[T]elescope [L]SP [T]ype [D]efinitions')
	nmap(
		'<leader>tlsw',
		require('telescope.builtin').lsp_dynamic_workspace_symbols,
		'[T]elescope [L]SP [S]ymbols [W]orkspace'
	)

	require('which-key').register({
		l = {
			name = 'LSP',
			c = { name = 'Code Action' },
			g = { name = 'Goto' },
			r = { name = 'Rename' },
			s = { name = 'Signature' },
		},
		t = {
			name = 'Telescope',
			l = {
				name = 'LSP',
				t = { name = 'Type' },
				s = { name = 'Symbols' },
			},
		},
	}, { prefix = '<leader>', buffer = bufnr, mode = 'n' })
end

return M
