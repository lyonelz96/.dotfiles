-------------------- HELPERS --------------------
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-------------------- PLUGINS --------------------
require('packer').startup(function(use)
    --- LOOKS ---
    use('eddyekofo94/gruvbox-flat.nvim')
    use('rebelot/kanagawa.nvim')
    use('nvim-lualine/lualine.nvim')
    use('kyazdani42/nvim-web-devicons')
    use('onsails/lspkind-nvim')
    use('romgrk/barbar.nvim')
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })

    --- LSP ---
    use('neovim/nvim-lspconfig')
    use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-nvim-lua')
    use('saadparwaiz1/cmp_luasnip')
    use('L3MON4D3/LuaSnip')
    use('rafamadriz/friendly-snippets')
    use('williamboman/nvim-lsp-installer')
    use('jose-elias-alvarez/null-ls.nvim')

    --- NAVIGATION ---
    use('nvim-lua/plenary.nvim')
    use('nvim-telescope/telescope.nvim')
    use('kyazdani42/nvim-tree.lua')
    use('ggandor/lightspeed.nvim')

    --- MISC ---
    use('kosayoda/nvim-lightbulb')
    use('windwp/nvim-autopairs')
    use('folke/which-key.nvim')
    use('numToStr/Comment.nvim')
    use('wbthomason/packer.nvim')
end)
-------------------- OPTIONS --------------------
vim.cmd([[colorscheme kanagawa]])
vim.g.gruvbox_flat_style = 'dark'

vim.opt.mouse:append('a')
vim.cmd([[autocmd BufEnter * set formatoptions-=cro]])

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
require('nvim-lsp-installer').setup({})

--- LSPCONFIG ---
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.emmet_ls.setup({
    filetypes = { 'html', 'css', 'eruby' },
    capabilities = capabilities,
})

lspconfig.html.setup({
    capabilities = capabilities,
})

lspconfig.solargraph.setup({
    capabilities = capabilities,
})

lspconfig.sumneko_lua.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
            format = {
                enable = true,
                defaultConfig = {
                    quote_style = 'single',
                },
            },
        },
    },
    capabilities = capabilities,
})

lspconfig.tsserver.setup({
    capabilities = capabilities,
})
-------------------- PLUGINS CONFIG ---------------------

--- NVIM-CMP ---
local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    },
    sources = {
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'buffer' },
    },
    formatting = {
        format = lspkind.cmp_format({
            with_text = true,
            menu = {
                buffer = '[buf]',
                nvim_lsp = '[LSP]',
                nvim_lua = '[api]',
                path = '[path]',
                luasnip = '[snip]',
            },
        }),
    },
    experimental = {
        ghost_text = true,
    },
})

--- NULL-LS ---
local null_ls = require('null-ls')

local eruby_beautifier = {
    name = 'eruby-beautifier',
    method = null_ls.methods.FORMATTING,
    generator = require('null-ls.helpers').formatter_factory({
        command = 'htmlbeautifier',
        args = { '--keep-blank-lines', '1' },
        to_stdin = true,
    }),
    filetypes = { 'eruby' },
}

null_ls.setup({
    sources = {
        eruby_beautifier,
    },
})

--- LUASNIP ---
require('luasnip/loaders/from_vscode').load()

--- TELESCOPE ---
map('n', '<leader>tfp', ':Telescope git_files<CR>')
map('n', '<leader>tff', ':Telescope find_files<CR>')
map('n', '<leader>tfg', ':Telescope live_grep<CR>')
map('n', '<leader>tfs', ':Telescope grep_string<CR>')
map('n', '<leader>tfe', ':Telescope file_browser<CR>')
map('n', '<leader>tvh', ':Telescope help_tags<CR>')
map('n', '<leader>tvb', ':Telescope buffers<CR>')
map('n', '<leader>tvf', ':Telescope current_buffer_fuzzy_find<CR>')
map('n', '<leader>tlD', ':Telescope lsp_document_diagnostics<CR>')
map('n', '<leader>tlr', ':Telescope lsp_references<CR>')
map('n', '<leader>tld', ':Telescope lsp_definitions<CR>')
map('n', '<leader>tli', ':Telescope lsp_implementations<CR>')

--- NVIM-TREE ---
require('nvim-tree').setup()

map('n', '<leader>nvt', ':NvimTreeToggle<CR>')

--- LUALINE ---
require('lualine').setup({})

--- AUTOPAIRS ---
require('nvim-autopairs').setup({})

--- BARBAR ---
map('n', '<leader>bbp', ':BufferPick<CR>')
map('n', '<leader>bbc', ':BufferClose<CR>')
map('n', '<leader>bbd', ':BufferCloseAllButPinned<CR>')
map('n', '<leader>bbh', ':BufferPrevious<CR>')
map('n', '<leader>bbl', ':BufferNext<CR>')

--- LIGHTBULB ---
vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])

--- WHICH KEY ---
require('which-key').setup({})

--- COMMENT ---
require('Comment').setup({
    toggler = {
        line = '<leader>gcc',
        block = '<leader>gbc',
    },
    opleader = {
        line = '<leader>gc',
        block = '<leader>gb',
    },
})

--- TREESITTER ---
require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
    },
})
