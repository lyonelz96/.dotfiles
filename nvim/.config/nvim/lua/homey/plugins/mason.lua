return {
	"williamboman/mason.nvim",
	lazy = false,
	priority = 100,
	config = function()
		require("mason").setup()
	end,
}
