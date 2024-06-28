local vim = vim
require('telescope').setup()
require("nvim-treesitter").setup()
require('markdown').setup()
require("nvim-devdocs").setup()
require('Comment').setup()
require("startup").setup({theme = "dashboard"})
require('lualine').setup({theme = 'dracula'})
require('glow').setup({width_ratio = 1, height_ratio = 1})
require('neoscroll').setup({easing = "quadratic"})
require("toggleterm").setup {
    shade_terminals = true,
    float_opts = {border = 'curved', height = 5}
}
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    direction = "float",
    float_opts = {border = 'double', height = 40},
    hidden = true
})
function _lazygit() lazygit:toggle() end
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
-- linting
local lint = require('lint')
lint.linters_by_ft = {
    python = {'pylint'},
    javascript = {'eslint'},
    typescript = {'typescript-language-server'},
    json = {'jsonlint'},
    markdown = {'vale'},
    lua = {'luacheck'}
}

-- language server
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
vim.api.nvim_create_autocmd({"BufWritePost"},
                            {callback = function() lint.try_lint() end})

-- completion
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
    sources = cmp.config.sources({
        {name = 'nvim_lsp'}, {name = 'luasnip'} -- For luasnip users.
    }, {{name = 'buffer'}})
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
