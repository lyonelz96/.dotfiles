return {
	"stevearc/dressing.nvim", -- improve the default vim.ui interfaces
	config = function()
		require("dressing").setup({
			input = { insert_only = false },
		})
	end,
}
