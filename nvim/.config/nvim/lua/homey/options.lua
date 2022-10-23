local options = {
	-- indentation
	tabstop = 4,
	softtabstop = 4,
	shiftwidth = 4,
	expandtab = true,
	smartindent = true,

	-- meta
	backup = false,
	writebackup = true,
	swapfile = false,
	undofile = true,

	-- visuals
	relativenumber = true,
	number = true,
	signcolumn = 'yes',
	colorcolumn = '80',
	cursorline = true,
	termguicolors = true,
	showmode = false,
	scrolloff = 8,
	wrap = false,

	-- search
	hlsearch = false,
	incsearch = true,
}

for name, value in pairs(options) do
	vim.opt[name] = value
end
