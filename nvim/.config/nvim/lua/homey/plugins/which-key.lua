return {
	"folke/which-key.nvim", -- displays a popup with possible key bindings
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		require("which-key").setup()

		require("which-key").register({
			["<leader>f"] = { name = "[F]ile", _ = "which_key_ignore" },
			["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
			["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
			["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
			["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
			["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
		})
	end,
}
