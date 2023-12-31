return {
	"nvim-lualine/lualine.nvim", -- statusline
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local single_char_mode = function(mode)
			return mode:sub(1, 1)
		end

		local get_lsps = function()
			local lsps = vim.lsp.get_active_clients({ bufnr = 0 })
			if #lsps == 0 then
				return ""
			end

			local get_lsps_names = function()
				local names = {}

				for i = 1, #lsps, 1 do
					table.insert(names, lsps[i]["name"])
				end

				return names
			end
			return " " .. table.concat(get_lsps_names(), ", ")
		end

		local get_formatters = function()
			local formatters = require("conform").list_formatters(0)
			if #formatters == 0 then
				return ""
			end

			local get_formatters_names = function()
				local names = {}

				for i = 1, #formatters, 1 do
					table.insert(names, formatters[i]["name"])
				end

				return names
			end
			return "󰁨 " .. table.concat(get_formatters_names(), ", ")
		end

		local get_linters = function()
			local linters = require("lint").get_running()
			if #linters == 0 then
				return ""
			end
			return "󱉶 " .. table.concat(linters, ", ")
		end

		local get_time = function()
			return tostring(os.date("%I:%M %p")):upper()
		end

		require("lualine").setup({
			sections = {
				lualine_a = { { "mode", fmt = single_char_mode, icon = "󰊠" } },
				lualine_x = { { get_lsps }, { get_formatters }, { get_linters } },
				lualine_y = { "filetype" },
				lualine_z = { { get_time, icon = "" } },
			},
		})
	end,
}
