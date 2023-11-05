return {
	"stevearc/conform.nvim", -- formatting
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
			},
		})

		vim.keymap.set("n", "<leader>ff", require("conform").format, { desc = "[F]ormat [F]ile" })
	end,
}
