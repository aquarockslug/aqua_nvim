-- AQUA ARCH NEOVIM
-- The main nvim configuration file
local vim = vim -- avoid undefined var warning

-- SETUP
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autochdir = true
vim.cmd 'colorscheme dracula'
vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'
vim.cmd 'let mapleader=","'
require'autoclose'.setup()
require'Comment'.setup()
require'markdown'.setup()
require'minintro'.setup()
require'nvim-devdocs'.setup()
require'nvim-treesitter'.setup({auto_install = true})
require'lualine'.setup({theme = 'dracula'})
require'glow'.setup({width_ratio = 1, height_ratio = 1})
require'neoscroll'.setup({easing = 'quadratic'})

-- TERMINAL
require"toggleterm".setup {
    shade_terminals = true,
    float_opts = {border = 'curved', height = 5}
}
local Terminal = require'toggleterm.terminal'.Terminal
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

-- TELESCOPE
require'telescope'.setup()
-- require('vstask').setup()
require'telescope'.load_extension 'file_browser'
-- require('telescope').load_extension "vstask"
-- require('telescope').load_extension "fzf"

-- LINTING
local lint = require 'lint'
lint.linters_by_ft = {
    python = {'pylint'},
    javascript = {'eslint'},
    -- typescript = {'typescript-language-server'},
    json = {'jsonlint'},
    markdown = {'vale'},
    lua = {'luacheck'}
}

-- LANGUAGE SERVERS
local lspconfig = require 'lspconfig'
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
vim.api.nvim_create_autocmd({"BufWritePost"}, -- lint on save
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
