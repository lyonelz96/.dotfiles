local nt_api_ok, nt_api = pcall(require, 'nvim-tree.api')

if nt_api_ok then
    local nmap = require('homey.keymap').nmap

    nmap('<leader>ntt', nt_api.tree.toggle, { desc = '[N]vim [T]ree [T]oggle' })

    local wk_ok, wk = pcall(require, 'which-key')

    if wk_ok then
        wk.register({
            n = {
                name = 'NvimTree',
                t = { name = 'Toggle' },
            },
        }, { prefix = '<leader>', mode = 'n' })
    end
end
