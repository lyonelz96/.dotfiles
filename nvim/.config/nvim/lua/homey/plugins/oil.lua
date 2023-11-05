return {
	"stevearc/oil.nvim", -- file explorer
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup()

		vim.keymap.set("n", "<leader>fe", require("oil").toggle_float, { desc = "[F]ile [E]xplorer" })
	end,
}
