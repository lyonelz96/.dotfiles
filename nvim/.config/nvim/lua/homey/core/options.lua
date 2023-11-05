local opts = {
	-- line numbers
	number = true, -- print the line number in front of each line
	relativenumber = true, -- show relative line number in front of each line

	-- cursor line
	cursorline = true, -- highlight the screen line of the cursor

	-- wrapping
	wrap = false, -- long lines wrap and continue on the next line

	-- signcolumn
	signcolumn = "yes", -- when to display the sign column

	-- colorcolumn
	colorcolumn = "80", -- columns to highlight

	-- scrolloff
	scrolloff = 8, -- minimum nr. of lines above and below cursor

	-- searching
	hlsearch = false, -- highlight matches with last search pattern
	ignorecase = true, -- ignore case in search patterns
	smartcase = true, -- no ignore case when pattern has uppercase

	-- colors
	termguicolors = true, -- use GUI colors for the terminal

	-- indentation
	tabstop = 2, -- number of spaces that <Tab> in file uses
	softtabstop = 2, -- number of spaces that <Tab> uses while editing
	shiftwidth = 2, -- number of spaces to use for (auto)indent step
	expandtab = true, -- use spaces when <Tab> is inserted
	smartindent = true, -- smart autoindenting for C programs
	autoindent = true, -- take indent for new line from previous line

	-- swap/undo/backup
	swapfile = false, -- whether to use a swapfile for a buffer
	undofile = false, -- save undo information in a file
	backup = false, -- keep backup file after overwriting a file
}

for option, value in pairs(opts) do
	vim.opt[option] = value
end
