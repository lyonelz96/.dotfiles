local kanagawa_ok, kanagawa = pcall(require, 'kanagawa')

if kanagawa_ok then
    kanagawa.setup({ transparent = true })

    vim.cmd([[colorscheme kanagawa]])
end
