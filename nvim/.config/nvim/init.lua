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
	--- LSP ---
	'neovim/nvim-lspconfig',
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'saadparwaiz1/cmp_luasnip',
	'L3MON4D3/LuaSnip',
	'williamboman/nvim-lsp-installer',
	--- NAVIGATION ---
	'nvim-lua/plenary.nvim',
	'nvim-telescope/telescope.nvim',
	'kyazdani42/nvim-tree.lua',
	--- MISC ---
	'kosayoda/nvim-lightbulb',
	'windwp/nvim-autopairs',
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
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
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

--- MAPPINGS ---
map('n', '<leader>vf', ':lua vim.lsp.buf.formatting()<CR>')
map('n', '<leader>vd', ':lua vim.lsp.buf.definition()<CR>')
map('n', '<leader>vi', ':lua vim.lsp.buf.implementation()<CR>')
map('n', '<leader>vsh', ':lua vim.lsp.buf.signature_help()<CR>')
map('n', '<leader>vrr', ':lua vim.lsp.buf.references()<CR>')
map('n', '<leader>vrn', ':lua vim.lsp.buf.rename()<CR>')
map('n', '<leader>vh', ':lua vim.lsp.buf.hover()<CR>')
map('n', '<leader>vca', ':lua vim.lsp.buf.code_action()<CR>')
map('n', '<leader>vsd', ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
map('n', '<leader>vn', ':lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<leader>vp', ':lua vim.lsp.diagnostic.goto_prev()<CR>')

--- LSPINSTALLER ---
local lsp_installer = require('nvim-lsp-installer')

lsp_installer.on_server_ready(function(server)
	local opts = {
		capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	}

	if server.name == 'texlab' then
		opts.settings = {
			texlab = {
				build = {
					executable = 'latexmk',
					args = { '-pvc', '-lualatex', '-outdir=./build' },
					outputDirectory = './build',
					onSave = true,
				},
				auxDirectory = './build',
			},
		}
	end

	if server.name == 'diagnosticls' then
		opts.filetypes = { 'lua' }
		opts.init_options = {
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
		}
	end

	server:setup(opts)
	vim.cmd([[ do User LspAttachBuffers ]])
end)

-------------------- PLUGINS CONFIG ---------------------

--- NVIM-CMP ---
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local luasnip = require('luasnip')
local cmp = require('cmp')

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = {
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, {
			'i',
			's',
		}),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			'i',
			's',
		}),
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
map('n', '<leader>tf', ':Telescope find_files<CR>')
map('n', '<leader>tb', ':Telescope buffers<CR>')
map('n', '<leader>th', ':Telescope help_tags<CR>')
map('n', '<leader>tg', ':Telescope live_grep<CR>')
map('n', '<leader>td', ':Telescope lsp_document_diagnostics<CR>')
map('n', '<leader>tbr', ':Telescope file_browser<CR>')

--- NVIM-TREE ---
require('nvim-tree').setup()

map('n', '<leader>nvt', ':NvimTreeToggle<CR>')

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
