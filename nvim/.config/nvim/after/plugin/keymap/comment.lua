local comment_api_ok, comment_api = pcall(require, 'Comment.api')

if comment_api_ok then
    local maps = require('homey.keymap')
    local nmap = maps.nmap
    local vmap = maps.vmap

    nmap(
        '<leader>cl',
        comment_api.toggle.linewise.current,
        { desc = '[C]omment Current [L]ine' }
    )

    nmap('<leader>cc', function()
        comment_api.toggle.linewise.count(vim.v.count)
    end, { desc = '[C]omment [C]ount' })

    nmap(
        '<leader>co',
        comment_api.call('toggle.linewise', 'g@'),
        { desc = '[C]omment [O]perator', expr = true }
    )

    vmap('<leader>cb', function()
        local key = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.api.nvim_feedkeys(key, 'nx', false)
        comment_api.toggle.linewise(vim.fn.visualmode())
    end, { desc = '[C]omment [B]lock' })

    local wk_ok, wk = pcall(require, 'which-key')

    if wk_ok then
        wk.register({
            c = { name = 'Comment' },
        }, { prefix = '<leader>', mode = 'n' })

        wk.register({
            c = { name = 'Comment' },
        }, { prefix = '<leader>', mode = 'v' })
    end
end
