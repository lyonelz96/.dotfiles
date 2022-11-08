local M = {}

M.setup = function()
    local null_ls_ok, null_ls = pcall(require, 'null-ls')
    local mason_null_ls_ok, mason_null_ls = pcall(require, 'mason-null-ls')

    if null_ls_ok and mason_null_ls_ok then
        mason_null_ls.setup({
            ensure_installed = { 'stylua', 'selene' },
        })

        mason_null_ls.setup_handlers({
            stylua = function()
                null_ls.register(null_ls.builtins.formatting.stylua.with({
                    condition = function(utils)
                        return utils.root_has_file({ 'stylua.toml', '.stylua.toml' })
                    end,
                }))
            end,
            selene = function()
                null_ls.register(null_ls.builtins.diagnostics.selene.with({
                    condition = function(utils)
                        return utils.root_has_file({ 'selene.toml' })
                    end,
                }))
            end,
        })

        null_ls.register(null_ls.builtins.formatting.prettierd.with({
            only_local = 'node_modules/.bin',
        }))

        null_ls.register(null_ls.builtins.diagnostics.eslint_d.with({
            only_local = 'node_modules/.bin',
        }))

        null_ls.setup({})
    end
end

return M
