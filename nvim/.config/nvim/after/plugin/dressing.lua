local dressing_ok, dressing = pcall(require, 'dressing')

if dressing_ok then
    dressing.setup({
        input = {
            insert_only = false,
        },
    })
end
