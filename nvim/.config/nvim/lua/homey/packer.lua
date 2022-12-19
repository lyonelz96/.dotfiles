-- install packer
local install_path = vim.fn.stdpath('data')
    .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.execute(
        '!git clone https://github.com/wbthomason/packer.nvim ' .. install_path
    )
    vim.cmd([[packadd packer.nvim]])
end

require('packer').startup(function(use)
    -- package manager
    use('wbthomason/packer.nvim')

    -- looks
    use('rebelot/kanagawa.nvim')
    use('nvim-tree/nvim-web-devicons')

    -- lsp
    use({
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- lsp support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        },
    })

    -- nav
    use({
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } },
    })
    use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

    -- qol
    use({
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update =
                require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    })
    use('nvim-treesitter/nvim-treesitter-context')
    use({
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
    })

    if is_bootstrap then
        require('packer').sync()
    end
end)

if is_bootstrap then
    print('==================================')
    print('    Plugins are being installed')
    print('    Wait until Packer completes,')
    print('       then restart nvim')
    print('==================================')
    return
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | PackerSync',
    group = packer_group,
    pattern = 'packer.lua',
})
