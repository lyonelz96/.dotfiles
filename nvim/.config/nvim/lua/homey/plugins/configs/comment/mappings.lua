vim.keymap.set('n', '<leader>cl', require('Comment.api').toggle_current_linewise, { desc = '[C]omment [L]ine' })

vim.keymap.set('n', '<leader>cc', require('Comment.api').toggle_linewise_count, { desc = '[C]omment [C]ount' })

vim.keymap.set('v', '<leader>cb', function()
	local key = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
	vim.api.nvim_feedkeys(key, 'nx', false)
	require('Comment.api').toggle_linewise_op(vim.fn.visualmode())
end, { desc = '[C]omment [B]lock' })
