require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')

vim.keymap.set(
    'n',
    '<leader><space>',
    builtin.buffers,
    { desc = '[ ] Find Existing Buffers' }
)

vim.keymap.set(
    'n',
    '<leader>/',
    builtin.current_buffer_fuzzy_find,
    { desc = '[/] Fuzzily Search In Current Buffer' }
)

vim.keymap.set(
    'n',
    '<leader>sf',
    builtin.find_files,
    { desc = '[S]earch [F]iles' }
)
vim.keymap.set(
    'n',
    '<leader>sp',
    builtin.git_files,
    { desc = '[S]earch Git Files [P]' }
)
vim.keymap.set(
    'n',
    '<leader>sh',
    builtin.help_tags,
    { desc = '[S]earch [H]elp' }
)
vim.keymap.set(
    'n',
    '<leader>sk',
    builtin.keymaps,
    { desc = '[S]earch [K]eymaps' }
)
vim.keymap.set(
    'n',
    '<leader>sw',
    builtin.grep_string,
    { desc = '[S]earch Current [W]ord' }
)
vim.keymap.set(
    'n',
    '<leader>sg',
    builtin.live_grep,
    { desc = '[S]earch By [G]rep' }
)
