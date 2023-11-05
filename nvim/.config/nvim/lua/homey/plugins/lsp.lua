return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim builtin lsp client
		"williamboman/mason-lspconfig.nvim", -- lspconfig mason extension
		"folke/neodev.nvim", -- automatic lua lsp config for init.lua
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.4", -- fuzzy finder
			dependencies = { "nvim-lua/plenary.nvim" },
		},
	},
	config = function()
		require("neodev").setup()
		require("mason-lspconfig").setup()

		-- automatic server setup
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		require("mason-lspconfig").setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
				})
			end,
		})

		-- keymaps set after language server attaches to current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(ev)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "[R]e[n]ame" })
				vim.keymap.set(
					"n",
					"<leader>ca",
					vim.lsp.buf.code_action,
					{ buffer = ev.buf, desc = "[C]ode [A]ction" }
				)

				vim.keymap.set(
					"n",
					"gd",
					require("telescope.builtin").lsp_definitions,
					{ buffer = ev.buf, desc = "[G]oto [D]efinition" }
				)
				vim.keymap.set(
					"n",
					"gr",
					require("telescope.builtin").lsp_references,
					{ buffer = ev.buf, desc = "[G]oto [R]eferences" }
				)
				vim.keymap.set(
					"n",
					"gI",
					require("telescope.builtin").lsp_implementations,
					{ buffer = ev.buf, desc = "[G]oto [I]mplementation" }
				)
				vim.keymap.set(
					"n",
					"<leader>D",
					require("telescope.builtin").lsp_type_definitions,
					{ buffer = ev.buf, desc = "Type [D]efinitions" }
				)
				vim.keymap.set(
					"n",
					"<leader>ds",
					require("telescope.builtin").lsp_document_symbols,
					{ buffer = ev.buf, desc = "[D]ocument [S]ymbols" }
				)
				vim.keymap.set(
					"n",
					"<leader>ws",
					require("telescope.builtin").lsp_dynamic_workspace_symbols,
					{ buffer = ev.buf, desc = "[W]orkspace [S]ymbols" }
				)

				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover Documentation" })
				vim.keymap.set(
					"n",
					"<C-k>",
					vim.lsp.buf.signature_help,
					{ buffer = ev.buf, desc = "Signature Documentation" }
				)
			end,
		})
	end,
}
