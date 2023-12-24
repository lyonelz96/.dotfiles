return {
	"stevearc/conform.nvim", -- formatting
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
			},
		})

		vim.keymap.set("n", "<leader>ff", function()
			require("conform").format({ lsp_fallback = true })
		end, { desc = "[F]ormat [F]ile" })
	end,
}
