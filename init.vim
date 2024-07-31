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
map <C-left> :tabpreviou,<CR>
map <C-up> :tabs<CR>
map <C-down> :tabrewind<CR>

call plug#begin('~/.local/share/nvim/site/plugged')
Plug 'echasnovski/mini.animate'
Plug 'echasnovski/mini.ai' " va
Plug 'echasnovski/mini.comment' " gc
Plug 'echasnovski/mini.pairs'
Plug 'echasnovski/mini.splitjoin' " gS
Plug 'echasnovski/mini.surround' " sa
Plug 'echasnovski/mini.tabline'
Plug 'echasnovski/mini.indentscope'
Plug 'echasnovski/mini.jump'
Plug 'echasnovski/mini.notify'
Plug 'echasnovski/mini.trailspace' " MiniTrailspace.trim(), make autocmd?

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'sbdchd/neoformat'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-telescope/telescope.nvim'
Plug 'NvChad/nvim-colorizer.lua'
Plug 'prichrd/netrw.nvim'
Plug 'akinsho/toggleterm.nvim'
Plug 'mfussenegger/nvim-lint'
Plug 'errata-ai/vale'
Plug 'rinx/nvim-ripgrep'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'tree-sitter/tree-sitter'
Plug 'tree-sitter/tree-sitter-html'
Plug 'kristijanhusak/vim-carbon-now-sh'
Plug 'tadmccorkle/markdown.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'eoh-bse/minintro.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'luckasRanarison/nvim-devdocs'
call plug#end()
