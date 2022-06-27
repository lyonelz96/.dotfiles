require('telescope').load_extension('fzf')

vim.keymap.set('n', '<leader>tff', require('telescope.builtin').find_files, { desc = '[T]elescope [F]ind [F]iles' })
vim.keymap.set('n', '<leader>tp', require('telescope.builtin').git_files, { desc = '[T]elescope Ctrl-[P]' })
vim.keymap.set('n', '<leader>tgs', require('telescope.builtin').grep_string, { desc = '[T]elescope [G]rep [S]tring' })
vim.keymap.set('n', '<leader>tgl', require('telescope.builtin').live_grep, { desc = '[T]elescope [G]rep [L]ive' })

vim.keymap.set('n', '<leader>th', require('telescope.builtin').help_tags, { desc = '[T]elescope [H]elp Tags' })
vim.keymap.set('n', '<leader>td', require('telescope.builtin').diagnostics, { desc = '[T]elescope [D]iagnostics' })
vim.keymap.set(
	'n',
	'<leader>tbf',
	require('telescope.builtin').current_buffer_fuzzy_find,
	{ desc = '[T]elescope [B]uffer [F]uzzy' }
)
