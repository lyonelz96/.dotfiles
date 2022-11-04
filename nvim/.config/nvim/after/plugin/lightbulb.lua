local lightbulb_ok, lightbulb = pcall(require, 'nvim-lightbulb')

if lightbulb_ok then
    lightbulb.setup({ autocmd = { enabled = true } })
end
