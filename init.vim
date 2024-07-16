" AQUA ARCH NEOVIM VIMSCRIPT
" vim-plug and movement keymap

" tmux movement
map <C-h> :wincmd h<CR>
map <C-j> :wincmd j<CR>
map <C-k> :wincmd k<CR>
map <C-l> :wincmd l<CR>

" nvim movement
map <up> <C-w><up>
map <down> <C-w><down>
map <left> <C-w><left>
map <right> <C-w><right>
map <C-right> :tabnext<CR>
map <C-left> :tabprevious<CR>
map <C-up> :tabs<CR>
map <C-down> :tabrewind<CR>

call plug#begin('~/.local/share/nvim/site/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'm4xshen/autoclose.nvim'
Plug 'sbdchd/neoformat'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'karb94/neoscroll.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-telescope/telescope.nvim'
Plug 'EthanJWright/vs-tasks.nvim'
Plug 'NvChad/nvim-colorizer.lua'
Plug 'numToStr/Comment.nvim'
Plug 'akinsho/toggleterm.nvim'
Plug 'mfussenegger/nvim-lint'
Plug 'errata-ai/vale'
Plug 'jesseduffield/lazygit'
Plug 'rinx/nvim-ripgrep'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'tree-sitter/tree-sitter'
Plug 'tree-sitter/tree-sitter-html'
Plug 'luckasRanarison/nvim-devdocs'
Plug 'kristijanhusak/vim-carbon-now-sh'
Plug 'tadmccorkle/markdown.nvim'
Plug 'ellisonleao/glow.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons' 	
Plug 'echasnovski/mini.tabline'
Plug 'eoh-bse/minintro.nvim'
call plug#end()
