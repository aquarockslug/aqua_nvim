-- AQUA ARCH NEOVIM
-- The main nvim configuration file
local vim = vim -- avoid undefined var warning

-- SETUP
vim.g.mapleader = ','
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autochdir = true
vim.cmd 'colorscheme dracula'
vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'
require'autoclose'.setup()
require'Comment'.setup()
require'todo-comments'.setup()
require'netrw'.setup()
require'markdown'.setup()
require'nvim-devdocs'.setup()
require'minintro'.setup({color = '#af87ff'})
require'nvim-treesitter'.setup({auto_install = true})
require'lualine'.setup({theme = 'dracula'})
require'neoscroll'.setup({easing = 'quadratic'})

-- FUNCTION KEYS
require'toggleterm'.setup {shade_terminals = true}
local Terminal = require'toggleterm.terminal'.Terminal

local lazygit = Terminal:new({cmd = 'lazygit', direction = 'float'})
vim.keymap.set('n', '<F1>', function() lazygit:toggle() end)

vim.keymap.set('n', '<F2>', ':Neoformat<CR> :w<CR>')

local web_search = Terminal:new({
    cmd = 'ddgr --rev --colors HGgffH',
    direction = 'float'
})
vim.keymap.set('n', '<F3>', function() web_search:toggle() end)

local buku = Terminal:new({cmd = 'oil', direction = 'float'})
vim.keymap.set('n', '<F4>', function() buku:toggle() end)

local nap = Terminal:new({cmd = 'nap', direction = 'float'})
vim.keymap.set('n', '<F5>', function() nap:toggle() end)

-- LINTING
local lint = require 'lint'
lint.linters_by_ft = {
    python = {'pylint'},
    javascript = {'eslint'},
    json = {'jsonlint'},
    markdown = {'vale'},
    lua = {'luacheck'}
}

-- LANGUAGE SERVERS
local lspconfig = require 'lspconfig'
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
vim.api.nvim_create_autocmd({'BufWritePost'}, -- lint on save
{callback = function() lint.try_lint() end})

-- COMPLETION
local cmp = require 'cmp'
cmp.setup({
    snippet = {
        expand = function(args) require'luasnip'.lsp_expand(args.body) end
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
local capabilities = require'cmp_nvim_lsp'.default_capabilities()
lspconfig['tsserver'].setup {capabilities = capabilities}
lspconfig['pyright'].setup {capabilities = capabilities}
