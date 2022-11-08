return {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                checkThirdParty = false,
            },
            format = {
                enable = true,
                defaultConfig = {
                    quote_style = 'single',
                    trailing_table_separator = 'smart',
                },
            },
        },
    },
}
