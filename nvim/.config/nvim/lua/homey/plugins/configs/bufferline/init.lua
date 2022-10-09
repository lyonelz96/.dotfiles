require('bufferline').setup({
	options = {
		offsets = {
			{
				filetype = 'NvimTree',
				text = 'File Explorer',
				text_align = 'center',
				separator = true,
			},
		},
	},
	highlights = {
		buffer_selected = {
			bold = false,
		},
	},
})

require('homey.plugins.configs.bufferline.mappings')
