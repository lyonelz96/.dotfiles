vim.keymap.set('n', '<leader>cl', require('Comment.api').toggle_current_linewise, { desc = '[C]omment Current [L]ine' })

vim.keymap.set('n', '<leader>cc', require('Comment.api').toggle_linewise_count, { desc = '[C]omment [C]ount' })

vim.keymap.set('n', '<leader>co', function()
	require('Comment.api').call('toggle_linewise_op')
	vim.api.nvim_feedkeys('g@', 'n', false)
end, { desc = '[C]omment [O]perator' })

vim.keymap.set('v', '<leader>cb', function()
	local key = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
	vim.api.nvim_feedkeys(key, 'nx', false)
	require('Comment.api').toggle_linewise_op(vim.fn.visualmode())
end, { desc = '[C]omment [B]lock' })
