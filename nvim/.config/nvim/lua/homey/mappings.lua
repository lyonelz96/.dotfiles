vim.g.mapleader = ' '

vim.keymap.set('v', 'J', [[:m '>+1<CR>gv=gv]])
vim.keymap.set('v', 'K', [[:m '<-2<CR>gv=gv]])

vim.keymap.set('n', '<leader>wj', '<Cmd>wincmd j<CR>')
vim.keymap.set('n', '<leader>wh', '<Cmd>wincmd h<CR>')
vim.keymap.set('n', '<leader>wk', '<Cmd>wincmd k<CR>')
vim.keymap.set('n', '<leader>wl', '<Cmd>wincmd l<CR>')

vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = '[D]iagnostic Goto [P]rev' })
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = '[D]iagnostic Goto [N]ext' })
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = '[D]iagnostic Open [F]loat' })
