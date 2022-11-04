local bufferline_ok, bufferline = pcall(require, 'bufferline')

if bufferline_ok then
    local nmap = require('homey.keymap').nmap

    nmap('<leader>bch', '<Cmd>BufferLineCloseLeft<CR>')
    nmap('<leader>bcl', '<Cmd>BufferLineCloseRight<CR>')
    nmap('<leader>bh', '<Cmd>BufferLineCyclePrev<CR>')
    nmap('<leader>bl', '<Cmd>BufferLineCycleNext<CR>')
    nmap('<leader>bp', '<Cmd>BufferLinePick<CR>')
    nmap('<leader>bcp', '<Cmd>BufferLinePickClose<CR>')
    nmap('<leader>btp', '<Cmd>BufferLineTogglePin<CR>')

    local bufferline_ui_ok, bufferline_ui = pcall(require, 'bufferline.ui')
    local bufferline_groups_ok, bufferline_groups =
        pcall(require, 'bufferline.groups')

    if bufferline_ui_ok and bufferline_groups_ok then
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

        nmap('<leader>bca', close_all, { desc = '[B]ufferline [C]lose [A]ll' })
        nmap(
            '<leader>bco',
            close_all_but_current,
            { desc = '[B]ufferline [C]lose [O]ther' }
        )
        nmap(
            '<leader>bcc',
            close_current,
            { desc = '[B]ufferline [C]lose [C]urrent' }
        )
    end

    local wk_ok, wk = pcall(require, 'which-key')

    if wk_ok then
        wk.register({
            b = {
                name = 'BufferLine',
                c = { name = 'BufferCloseOpts' },
            },
        }, { prefix = '<leader>', mode = 'n' })
    end
end
