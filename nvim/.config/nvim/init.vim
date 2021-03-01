syntax on

set guicursor=n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20
set completeopt=menuone,noselect
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
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
Plug 'glepnir/lspsaga.nvim'
Plug 'kosayoda/nvim-lightbulb'

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

require 'lspconfig'.tsserver.setup{}

require 'lspconfig'.html.setup{capabilities = capabilities}

require 'lspconfig'.cssls.setup{capabilities = capabilities}

require'lspconfig'.texlab.setup{
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

lua << EOF
require'compe'.setup {
  enabled = true;
  source = {
    path = true;
    buffer = true;
    nvim_lsp = true;
  };
}
EOF

lua << EOF
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
EOF

let g:vimsyn_embed = 'l'

let g:airline_theme = 'gruvbox_material'

let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeNaturalSort = 1

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

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <leader>ff  :lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>sll :lua vim.lsp.diagnostic.set_loclist()<CR>

nnoremap <silent><leader> gf <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
nnoremap <silent><leader> ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader> ca <cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<CR>
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent><leader> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
nnoremap <silent><leader> gr <cmd>lua require('lspsaga.rename').rename()<CR>
nnoremap <silent><leader> gd <cmd>lua require'lspsaga.provider'.preview_definition()<CR>
nnoremap <silent><leader> sd <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>
nnoremap <silent> [e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> ]e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>
nnoremap <silent> <A-d> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>
tnoremap <silent> <A-d> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>
