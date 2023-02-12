local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.set_preferences({
    suggest_lsp_servers = false,
    set_lsp_keymaps = false,
})

lsp.on_attach(function(_, bufnr)
    local map = function(mode, keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
    end
    -- lsp actions
    map('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    map('n', 'gD', vim.lsp.buf.declaration, '[G]o [D]eclaration')

    map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
    map(
        { 'n', 'i' },
        '<C-k>',
        vim.lsp.buf.signature_help,
        'Signature Documentation'
    )

    -- telescope lsp actions
    local builtin = require('telescope.builtin')

    map('n', 'gr', builtin.lsp_references, '[G]oto [R]eferences')
    map('n', 'gi', builtin.lsp_implementations, '[G]oto [I]mplementations')
    map('n', 'gd', builtin.lsp_definitions, '[G]oto [D]efinitions')
    map('n', '<leader>D', builtin.lsp_type_definitions, 'Type [D]efinitions')

    -- diagnostics
    map('n', '<leader>sd', builtin.diagnostics, '[S]earch [D]iagnostics')
    map('n', '<leader>e', vim.diagnostic.open_float, 'Show [E]rror')
    map('n', '[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
    map('n', ']d', vim.diagnostic.goto_next, 'Next Diagnostic')
end)

lsp.configure('lua_ls', {
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
})

lsp.setup_nvim_cmp({
    preselect = 'none',
    completion = {
        completeopt = 'menu,menuone,noinsert,noselect',
    },
})

lsp.setup()
