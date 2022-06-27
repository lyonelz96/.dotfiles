local nvim_tree_events = require('nvim-tree.events')
local bufferline_state = require('bufferline.state')

nvim_tree_events.on_tree_open(function()
	bufferline_state.set_offset(31, 'File Tree')
end)

nvim_tree_events.on_tree_close(function()
	bufferline_state.set_offset(0)
end)

vim.keymap.set('n', '<leader>bh', '<Cmd>BufferPrev<CR>')
vim.keymap.set('n', '<leader>bl', '<Cmd>BufferNext<CR>')
vim.keymap.set('n', '<leader>bp', '<Cmd>BufferPick<CR>')
vim.keymap.set('n', '<leader>bcc', '<Cmd>BufferClose<CR>')
vim.keymap.set('n', '<leader>bch', '<Cmd>BufferCloseBuffersLeft<CR>')
vim.keymap.set('n', '<leader>bcl', '<Cmd>BufferCloseBuffersRight<CR>')
vim.keymap.set('n', '<leader>bca', '<Cmd>BufferCloseAllButCurrent<CR>')
