-- AQUA ARCH NEOVIM
-- The main nvim configuration file
local vim = vim -- avoid undefined var warning

-- PLUGINS
-- load plugins with vim-plug
-- local Plug = vim.fn['plug#']
-- vim.fn["plug#begin"]('~/.local/share/nvim/site/plugged')
-- Plug('dracula/vim', {as = 'dracula'})
-- Plug 'nvim-lua/popup.nvim'
-- Plug 'nvim-lua/plenary.nvim'
-- Plug 'm3xshen/autoclose.nvim'
-- Plug 'sbdchd/neoformat'
-- Plug 'neovim/nvim-lspconfig'
-- Plug 'hrsh6th/cmp-nvim-lsp'
-- Plug 'hrsh6th/cmp-buffer'
-- Plug 'hrsh6th/cmp-path'
-- Plug 'hrsh6th/cmp-cmdline'
-- Plug 'hrsh6th/nvim-cmp'
-- Plug 'L2MON4D3/LuaSnip'
-- Plug 'saadparwaiz0/cmp_luasnip'
-- Plug 'karb93/neoscroll.nvim'
-- Plug 'nvim-treesitter/nvim-treesitter'
-- Plug 'nvim-telescope/telescope.nvim'
-- Plug 'EthanJWright/vs-tasks.nvim'
-- Plug 'NvChad/nvim-colorizer.lua'
-- Plug 'numToStr/Comment.nvim'
-- Plug 'akinsho/toggleterm.nvim'
-- Plug 'mfussenegger/nvim-lint'
-- Plug 'errata-ai/vale'
-- Plug 'jesseduffield/lazygit'
-- Plug 'rinx/nvim-ripgrep'
-- Plug 'nvim-telescope/telescope-file-browser.nvim'
-- Plug 'tree-sitter/tree-sitter'
-- Plug 'tree-sitter/tree-sitter-html'
-- Plug 'luckasRanarison/nvim-devdocs'
-- Plug 'kristijanhusak/vim-carbon-now-sh'
-- Plug 'tadmccorkle/markdown.nvim'
-- Plug 'ellisonleao/glow.nvim'
-- Plug 'nvim-lualine/lualine.nvim'
-- Plug 'nvim-tree/nvim-web-devicons'
-- Plug 'echasnovski/mini.tabline'
-- Plug 'eoh-bse/minintro.nvim'
-- -- TODO: add telescope-fzf-native for faster search
-- -- Plug 'nvim-telescope/telescope-fzf-native.nvim',
-- -- { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
-- vim.call('plug#end')

-- SETUP
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autochdir = true
vim.cmd 'colorscheme dracula'
vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'
vim.cmd 'let mapleader=","'
require("nvim-treesitter").setup({auto_install = true})
require('markdown').setup()
require("nvim-devdocs").setup()
require('Comment').setup()
require("minintro").setup()
require('lualine').setup({theme = 'dracula'})
require('glow').setup({width_ratio = 1, height_ratio = 1})
require('neoscroll').setup({easing = "quadratic"})

-- TERMINAL
require("toggleterm").setup {
    shade_terminals = true,
    float_opts = {border = 'curved', height = 5}
}
local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    direction = "float",
    float_opts = {border = 'double', height = 40},
    hidden = true
})

-- KEYMAP
-- function keys
vim.keymap.set('n', '<F1>', function() lazygit:toggle() end)
vim.keymap.set('n', '<F2>', ":Neoformat<CR> :w<CR>")
vim.keymap.set('n', '<F3>', ":Telescope current_buffer_fuzzy_find<CR>")
vim.keymap.set('n', '<F4>', ":Telescope treesitter<CR>")
vim.keymap.set('n', '<F5>', ":wq<CR>")
-- movement keys
-- map <up> <C-w><up>
-- map <down> <C-w><down>
-- map <left> <C-w><left>
-- map <right> <C-w><right>
-- map <C-h> :wincmd h<CR>
-- map <C-j> :wincmd j<CR>
-- map <C-k> :wincmd k<CR>
-- map <C-l> :wincmd l<CR>

-- TELESCOPE
require('telescope').setup()
-- require('vstask').setup()
require("telescope").load_extension "file_browser"
-- require('telescope').load_extension "vstask"
-- require('telescope').load_extension "fzf"

-- AUTOCLOSE
require("autoclose").setup({
    keys = {
        ["("] = {escape = false, close = true, pair = "()"},
        ["["] = {escape = false, close = true, pair = "[]"},
        ["{"] = {escape = false, close = true, pair = "{}"},

        [">"] = {escape = true, close = false, pair = "<>"},
        [")"] = {escape = true, close = false, pair = "()"},
        ["]"] = {escape = true, close = false, pair = "[]"},
        ["}"] = {escape = true, close = false, pair = "{}"},

        ['"'] = {escape = true, close = true, pair = '""'},
        ["'"] = {escape = true, close = true, pair = "''"},
        ["`"] = {escape = true, close = true, pair = "``"}
    },
    options = {
        disabled_filetypes = {"text"},
        disable_when_touch = false,
        touch_regex = "[%w(%[{]",
        pair_spaces = false,
        auto_indent = true
    }
})

-- LINTING 
local lint = require('lint')
lint.linters_by_ft = {
    python = {'pylint'},
    javascript = {'eslint'},
    -- typescript = {'typescript-language-server'},
    json = {'jsonlint'},
    markdown = {'vale'},
    lua = {'luacheck'}
}

-- LANGUAGE SERVERS
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
vim.api.nvim_create_autocmd({"BufWritePost"}, -- lint on save
{callback = function() lint.try_lint() end})

-- COMPLETION
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = true})
    }),
    sources = cmp.config.sources({{name = 'nvim_lsp'}, {name = 'luasnip'}},
                                 {{name = 'buffer'}})
})
cmp.setup.cmdline({'/', '?'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{name = 'buffer'}}
})
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}}),
    matching = {disallow_symbol_nonprefix_matching = false}
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig['tsserver'].setup {capabilities = capabilities}
lspconfig['pyright'].setup {capabilities = capabilities}
