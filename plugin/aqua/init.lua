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

require'mini.ai'.setup()
require'mini.animate'.setup() -- TODO: fix scrolling
require'mini.comment'.setup()
require'mini.indentscope'.setup({symbol = vim.g.mapleader})
require'mini.notify'.setup()
require'mini.pairs'.setup()
require'mini.splitjoin'.setup()
require'mini.surround'.setup()
require'mini.tabline'.setup()
require'mini.trailspace'.setup()

require'lualine'.setup({theme = 'dracula'})
require'markdown'.setup()
require'minintro'.setup({color = '#af87ff'})
require'netrw'.setup()
require'nvim-devdocs'.setup()
require'nvim-treesitter'.setup({auto_install = true})
require'todo-comments'.setup()
require'toggleterm'.setup {shade_terminals = true}

-- LINTING
local lint = require 'lint'
lint.linters_by_ft = {
    javascript = {'eslint'},
    json = {'jsonlint'},
    lua = {'luacheck'},
    markdown = {'vale'},
    python = {'pylint'}
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
