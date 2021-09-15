-------------------- HELPERS --------------------
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-------------------- PLUGINS --------------------
require('paq')({
	--- LOOKS ---
	'eddyekofo94/gruvbox-flat.nvim',
	'hoob3rt/lualine.nvim',
	'kyazdani42/nvim-web-devicons',
	'windwp/nvim-autopairs',
	--- LSP ---
	'neovim/nvim-lspconfig',
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'saadparwaiz1/cmp_luasnip',
	'L3MON4D3/LuaSnip',
	'kabouzeid/nvim-lspinstall',
	--- NAVIGATION ---
	'nvim-lua/plenary.nvim',
	'nvim-telescope/telescope.nvim',
	--- MISC ---
	'kosayoda/nvim-lightbulb',
})

-------------------- OPTIONS --------------------
vim.cmd([[colorscheme gruvbox-flat]])
vim.g.gruvbox_flat_style = 'dark'

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '80'
vim.opt.cursorline = true

vim.opt.backup = false
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.scrolloff = 8
vim.opt.cmdheight = 1
vim.opt.termguicolors = true
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.opt.hidden = true
vim.opt.showmode = false
vim.opt.shortmess = 'c'
vim.opt.background = 'dark'
vim.cmd('set undodir=~/.config/nvim/undodir')

-------------------- MAPPINGS ----------------------
vim.g.mapleader = ' '

map('v', 'J', [[:m '>+1<CR>gv=gv]])
map('v', 'K', [[:m '<-2<CR>gv=gv]])
map('n', '<leader>h', ':wincmd h<CR>')
map('n', '<leader>j', ':wincmd j<CR>')
map('n', '<leader>k', ':wincmd k<CR>')
map('n', '<leader>l', ':wincmd l<CR>')

-------------------- LSP ---------------------------

--- LSPINSTALL ---
require('lspinstall').setup()
local DATA_PATH = vim.fn.stdpath('data')

--- CONFIG ---
local lspconfig = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

--- SNIPPET SUPPORT ---
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

--- LUA ---
local sumneko_root_path = DATA_PATH .. '/lspinstall/lua'
local sumneko_binary = sumneko_root_path .. '/sumneko-lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup({
	cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file('', true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

--- TEXLAB ---
lspconfig.latex.setup({
	settings = {
		texlab = {
			build = {
				executable = 'latexmk',
				args = { '-pvc', '-lualatex', '-outdir=./build' },
				outputDirectory = './build',
				onSave = true,
			},
			auxDirectory = './build',
		},
	},
})

--- DIAGNOSTICLS ---
lspconfig.diagnosticls.setup({
	cmd = { DATA_PATH .. '/lspinstall/diagnosticls/node_modules/.bin/diagnostic-languageserver', '--stdio' },
	filetypes = { 'lua' },
	init_options = {
		formatters = {
			stylua = {
				command = 'stylua',
				args = { '%file', '--quote-style', 'ForceSingle' },
				doesWriteToFile = true,
			},
		},
		formatFiletypes = {
			lua = 'stylua',
		},
	},
})

-------------------- PLUGINS CONFIG ---------------------

--- LUASNIP ---
local luasnip = require('luasnip')

--- NVIM-CMP ---
local cmp = require('cmp')

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		['<Tab>'] = function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
			elseif luasnip.expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
			else
				fallback()
			end
		end,
		['<S-Tab>'] = function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
			elseif luasnip.jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'path' },
		{ name = 'buffer' },
	},
})

--- TELESCOPE ---
map('n', '<C-p>', ':Telescope git_files<CR>')
map('n', '<leader>ff', ':Telescope find_files<CR>')
map('n', '<leader>fb', ':Telescope buffers<CR>')
map('n', '<leader>fh', ':Telescope help_tags<CR>')
map('n', '<leader>fg', ':Telescope live_grep<CR>')
map('n', '<leader>fd', ':Telescope lsp_document_diagnostics<CR>')
map('n', '<leader>fb', ':Telescope file_browser<CR>')

--- LUALINE ---
require('lualine').setup({
	options = {
		theme = 'gruvbox-flat',
	},
})

--- AUTOPAIRS ---
require('nvim-autopairs').setup({})

--- LIGHTBULB ---
vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
