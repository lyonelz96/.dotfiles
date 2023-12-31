return {
	"mfussenegger/nvim-lint", -- linting
	config = function()
		vim.diagnostic.config({ float = { source = true } })

		require("lint").linters_by_ft = {
			sh = { "shellcheck" },
			yaml = { "yamllint" },
		}

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
