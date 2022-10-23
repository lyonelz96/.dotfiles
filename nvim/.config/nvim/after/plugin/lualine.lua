local lualine_ok, lualine = pcall(require, 'lualine')

if lualine_ok then
	lualine.setup({
		sections = {
			lualine_c = { { 'filename', file_status = true, path = 1 } },
		},
	})
end
