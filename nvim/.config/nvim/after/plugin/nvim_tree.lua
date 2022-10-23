local nvim_tree_ok, nvim_tree = pcall(require, 'nvim-tree')

if nvim_tree_ok then
	nvim_tree.setup({
		open_on_setup = true,
		diagnostics = {
			enable = true,
		},
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
	})
end
