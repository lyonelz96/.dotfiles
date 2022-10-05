vim.api.nvim_create_autocmd({ 'BufEnter' }, {
	pattern = { '*' },
	callback = function()
		vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
	end,
})

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '80'
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.showmode = false

vim.opt.hlsearch = false
vim.opt.scrolloff = 8
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.mouse = 'a'
vim.opt.wrap = false
