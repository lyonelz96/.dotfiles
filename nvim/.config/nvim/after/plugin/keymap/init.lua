local maps = require('homey.keymap')
local nmap = maps.nmap
local vmap = maps.vmap

vmap('J', [[:m '>+1<CR>gv=gv]])
vmap('K', [[:m '<-2<CR>gv=gv]])

nmap('<leader>wj', '<Cmd>wincmd j<CR>')
nmap('<leader>wh', '<Cmd>wincmd h<CR>')
nmap('<leader>wk', '<Cmd>wincmd k<CR>')
nmap('<leader>wl', '<Cmd>wincmd l<CR>')

nmap(
    '<leader>dp',
    vim.diagnostic.goto_prev,
    { desc = '[D]iagnostic Goto [P]rev' }
)
nmap(
    '<leader>dn',
    vim.diagnostic.goto_next,
    { desc = '[D]iagnostic Goto [N]ext' }
)
nmap('<leader>df', function()
    vim.diagnostic.open_float({ source = true })
end, { desc = '[D]iagnostic Open [F]loat' })

local wk_ok, wk = pcall(require, 'which-key')
if wk_ok then
    wk.register({
        d = { name = 'Diagnostic' },
        w = { name = 'Window' },
    }, { prefix = '<leader>', mode = 'n' })
end
