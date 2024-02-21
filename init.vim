set number
call plug#begin('~/.local/share/nvim/site/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'nvim-lua/plenary.nvim'
Plug 'm4xshen/autoclose.nvim'
Plug 'startup-nvim/startup.nvim',
Plug 'junegunn/goyo.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sbdchd/neoformat'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-telescope/telescope.nvim'
Plug 'NvChad/nvim-colorizer.lua'
Plug 'sitiom/nvim-numbertoggle'
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
Plug 'habamax/vim-godot'
Plug 'kristijanhusak/vim-carbon-now-sh'
Plug 'tadmccorkle/markdown.nvim'
call plug#end()

colorscheme dracula
hi Normal guibg=NONE ctermbg=NONE

map <C-h> :wincmd h<CR>
map <C-j> :wincmd j<CR>
map <C-k> :wincmd k<CR>
map <C-l> :wincmd l<CR>

map <F1> :Neoformat<CR> :w<CR>
map <F2> :lua _lazygit()<CR>
map <F3> :Telescope current_buffer_fuzzy_find<CR>
map <F4> :Telescope treesitter<CR>
map <F5> :TermExec direction=vertical dir=./ border=double size=70 cmd=''<CR>
map <F6> :DevdocsOpenCurrent<CR>

map <F10> :Goyo<CR>
" map <F11> fullscreen
map <F12> :wq<CR>

let g:airline_theme='soda'
