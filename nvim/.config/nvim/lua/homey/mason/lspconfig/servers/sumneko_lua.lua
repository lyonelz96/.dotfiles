return {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
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
