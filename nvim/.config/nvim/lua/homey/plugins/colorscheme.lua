return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			transparent = true, -- don't set background color
		})

		vim.cmd.colorscheme("kanagawa")
	end,
}
