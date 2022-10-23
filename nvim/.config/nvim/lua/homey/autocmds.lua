local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = { '*' },
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
	callback = function()
		vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
	end,
	pattern = { '*' },
})
