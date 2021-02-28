syntax on

set guicursor=n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20
set completeopt=menuone,noinsert,noselect
set updatetime=50
set shortmess+=c
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu rnu
set nowrap
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set scrolloff=8
set noshowmode
set nohlsearch
set hidden
set colorcolumn=80

set nocompatible

call plug#begin('~/.config/nvim/plugged')
Plug 'sainnhe/gruvbox-material'
Plug 'gruvbox-community/gruvbox'
Plug 'dylanaraps/wal.vim'
Plug 'vim-airline/vim-airline'

Plug 'neovim/nvim-lspconfig'
Plug 'sheerun/vim-polyglot'
Plug 'nvim-lua/completion-nvim'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'kyazdani42/nvim-web-devicons'

Plug 'ThePrimeagen/vim-be-good'
call plug#end()

if has('termguicolors')
    set termguicolors
endif

colorscheme gruvbox-material 

highlight Normal guibg=none ctermbg=none

lua << EOF
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require 'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}

require 'lspconfig'.html.setup{
    capabilities = capabilities,
    on_attach=require'completion'.on_attach
}

require 'lspconfig'.cssls.setup{
    capabilities = capabilities,
    on_attach=require'completion'.on_attach
}

require'lspconfig'.texlab.setup{
    on_attach=require'completion'.on_attach,
    settings = {
        latex = {
            build = {
                executable = "latexmk";
                args = {"-lualatex", "-outdir=./build", "-pvc"};
                onSave = true;
                outputDirectory = "./build";
            }
        }
    }
}
EOF

let g:vimsyn_embed = 'l'

let g:airline_theme = 'gruvbox_material'

let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeNaturalSort = 1

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy' ]
let g:completion_trigger_on_delete = 1

let mapleader=" "

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <silent> <Leader>= :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap <leader>p "_dP

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

nnoremap <leader>pf <cmd>Telescope find_files<cr>
nnoremap <C-p> <cmd>Telescope git_files<cr>
nnoremap <leader>pb <cmd>Telescope buffers<cr>
nnoremap <leader>vh <cmd>Telescope help_tags<cr>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <leader>gd  :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gi  :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>gr  :lua vim.lsp.buf.references()<CR>
nnoremap <leader>gsh  :lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent>K   :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>ff  :lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>rn  :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>se  :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <leader>gpe :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <leader>gne :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>sll :lua vim.lsp.diagnostic.set_loclist()<CR>
