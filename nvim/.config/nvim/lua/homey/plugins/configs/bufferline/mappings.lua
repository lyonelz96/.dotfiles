vim.keymap.set('n', '<leader>bch', '<Cmd>BufferLineCloseLeft<CR>')
vim.keymap.set('n', '<leader>bcl', '<Cmd>BufferLineCloseRight<CR>')
vim.keymap.set('n', '<leader>bh', '<Cmd>BufferLineCyclePrev<CR>')
vim.keymap.set('n', '<leader>bl', '<Cmd>BufferLineCycleNext<CR>')
vim.keymap.set('n', '<leader>bp', '<Cmd>BufferLinePick<CR>')
vim.keymap.set('n', '<leader>bcp', '<Cmd>BufferLinePickClose<CR>')
vim.keymap.set('n', '<leader>btp', '<Cmd>BufferLineTogglePin<CR>')

local bufferline = require('bufferline')
local bufferline_ui = require('bufferline.ui')
local bufferline_groups = require('bufferline.groups')

local function close_all()
	for _, e in ipairs(bufferline.get_elements().elements) do
		if not (bufferline_groups.is_pinned(e)) then
			vim.schedule(function()
				vim.cmd('bd' .. e.id)
			end)
		end
	end

	vim.schedule(function()
		bufferline_ui.refresh()
	end)
end

local function close_all_but_current()
	for _, e in ipairs(bufferline.get_elements().elements) do
		if e.path ~= vim.api.nvim_buf_get_name(0) then
			vim.schedule(function()
				vim.cmd('bd' .. e.id)
			end)
		end
	end

	vim.schedule(function()
		bufferline_ui.refresh()
	end)
end

local function close_current()
	for _, e in ipairs(bufferline.get_elements().elements) do
		if e.path == vim.api.nvim_buf_get_name(0) then
			vim.schedule(function()
				vim.cmd('bd' .. e.id)
			end)
		end
	end

	vim.schedule(function()
		bufferline_ui.refresh()
	end)
end

vim.keymap.set('n', '<leader>bca', close_all, { desc = '[B]ufferline [C]lose [A]ll' })
vim.keymap.set('n', '<leader>bco', close_all_but_current, { desc = '[B]ufferline [C]lose [O]ther' })
vim.keymap.set('n', '<leader>bcc', close_current, { desc = '[B]ufferline [C]lose [C]urrent' })

require('which-key').register({
	b = {
		name = 'BufferLine',
		c = { name = 'BufferCloseOpts' },
	},
}, { prefix = '<leader>', mode = 'n' })
