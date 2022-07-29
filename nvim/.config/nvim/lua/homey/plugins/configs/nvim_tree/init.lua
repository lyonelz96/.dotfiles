require('nvim-tree').setup({
	diagnostics = {
		enable = true,
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
})

require('homey.plugins.configs.nvim_tree.mappings')
