local M = {}

local function map(mode)
	vim.g.mapleader = ' '

	return function(lhs, rhs, extra_opts)
		local opts = { noremap = true, silent = true }

		if extra_opts then
			opts = vim.tbl_extend('force', opts, extra_opts)
		end

		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

M.nmap = map('n')
M.vmap = map('v')
M.imap = map('i')

return M
