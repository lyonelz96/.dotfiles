function kanagawa()
    require('kanagawa').setup({ transparent = true })
end

function set_theme(theme)
    theme.setup()
    vim.cmd('colorscheme' .. ' ' .. theme.name)
end

set_theme({ setup = kanagawa, name = 'kanagawa' })
