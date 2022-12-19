vim.g.mapleader = ' '

-- drag things
vim.keymap.set('v', 'J', [[:m '>+1<CR>gv=gv]])
vim.keymap.set('v', 'K', [[:m '<-2<CR>gv=gv]])

-- move between windows
vim.keymap.set('n', '<leader>j', '<cmd>wincmd j<cr>')
vim.keymap.set('n', '<leader>h', '<cmd>wincmd h<cr>')
vim.keymap.set('n', '<leader>k', '<cmd>wincmd k<cr>')
vim.keymap.set('n', '<leader>l', '<cmd>wincmd l<cr>')

-- better J
vim.keymap.set('n', 'J', 'mzJ`z')

-- keep cursor in middle
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- clipboard yank
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')
