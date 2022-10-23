local telescope_builtin_ok, telescope_builtin = pcall(require, 'telescope.builtin')

if telescope_builtin_ok then
	local nmap = require('homey.keymap').nmap

	nmap('<leader>tff', telescope_builtin.find_files, { desc = '[T]elescope [F]ind [F]iles' })
	nmap('<leader>tp', telescope_builtin.git_files, { desc = '[T]elescope Ctrl-[P]' })
	nmap('<leader>tgs', telescope_builtin.grep_string, { desc = '[T]elescope [G]rep [S]tring' })
	nmap('<leader>tgl', telescope_builtin.live_grep, { desc = '[T]elescope [G]rep [L]ive' })

	nmap('<leader>th', telescope_builtin.help_tags, { desc = '[T]elescope [H]elp Tags' })
	nmap('<leader>td', telescope_builtin.diagnostics, { desc = '[T]elescope [D]iagnostics' })
	nmap('<leader>tbf', telescope_builtin.current_buffer_fuzzy_find, { desc = '[T]elescope [B]uffer [F]uzzy' })

	local wk_ok, wk = pcall(require, 'which-key')

	if wk_ok then
		wk.register({
			t = {
				name = 'Telescope',
				b = { name = 'Buffer' },
				f = { name = 'Find' },
				g = { name = 'Grep' },
			},
		}, { prefix = '<leader>', mode = 'n' })
	end
end
