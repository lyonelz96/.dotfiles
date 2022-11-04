local bufferline_ok, bufferline = pcall(require, 'bufferline')

if bufferline_ok then
    bufferline.setup({
        options = {
            show_close_icon = false,
            diagnostics = 'nvim_lsp',
            offsets = {
                {
                    filetype = 'NvimTree',
                    text = 'File Explorer',
                    text_align = 'center',
                    separator = true,
                },
            },
        },
        highlights = {
            buffer_selected = {
                bold = false,
            },
        },
    })
end
