return {
	"mfussenegger/nvim-lint", -- linting
	config = function()
		vim.diagnostic.config({ float = { source = true } })

		require("lint").linters_by_ft = {}

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
