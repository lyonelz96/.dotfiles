vim.keymap.set('n', '<leader>cl', require('Comment.api').toggle.linewise.current, { desc = '[C]omment Current [L]ine' })

vim.keymap.set('n', '<leader>cc', function()
	require('Comment.api').toggle.linewise.count(vim.v.count)
end, { desc = '[C]omment [C]ount' })

vim.keymap.set(
	'n',
	'<leader>co',
	require('Comment.api').call('toggle.linewise', 'g@'),
	{ desc = '[C]omment [O]perator', expr = true }
)

vim.keymap.set('v', '<leader>cb', function()
	local key = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
	vim.api.nvim_feedkeys(key, 'nx', false)
	require('Comment.api').toggle.linewise(vim.fn.visualmode())
end, { desc = '[C]omment [B]lock' })

require('which-key').register({
	c = { name = 'Comment' },
}, { prefix = '<leader>', mode = 'n' })

require('which-key').register({
	c = { name = 'Comment' },
}, { prefix = '<leader>', mode = 'v' })
