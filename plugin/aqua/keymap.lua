-- AQUA ARCH NEOVIM KEYMAP
local vim = vim -- avoid undefined var warning
local Terminal = require'toggleterm.terminal'.Terminal

vim.keymap.set('n', 'U', '<C-r>') -- undo

-- FUNCTION KEYS
-- F1
local lazygit = Terminal:new({cmd = 'lazygit', direction = 'float'})
vim.keymap.set('n', '<F1>', function() lazygit:toggle() end)

-- F2
vim.keymap.set('n', '<F2>', ':Neoformat<CR> :w<CR>')

-- F3
local web_search = Terminal:new({
    cmd = 'ddgr --rev',
    direction = 'float'
})
vim.keymap.set('n', '<F3>', function() web_search:toggle() end)

-- F4
local buku = Terminal:new({cmd = 'oil', direction = 'float'})
vim.keymap.set('n', '<F4>', function() buku:toggle() end)

-- F5
local nap = Terminal:new({cmd = 'nap', direction = 'float'})
vim.keymap.set('n', '<F5>', function() nap:toggle() end)

-- LEADER SHORTCUTS
for cmd, func in pairs({
    k = 'move-2<CR>==', -- shift line down
    j = 'move+<CR>==', -- shift line up
    h = 'noh<CR>', -- clear highlighting
    t = 'Texplore<CR>', -- open netrw in new tab
    o = 'Hexplore<CR>', -- open netrw in horizontal pane
    v = 'Vexplore<CR>' -- open netrw in vertical pane
}) do vim.keymap.set('n', '<leader>' .. cmd, ':' .. func) end

-- TELESCOPE SHORTCUTS
local telescope_prefix = '<leader>f'
local t = require('telescope')
local tb = require('telescope.builtin')
for cmd, func in pairs({
    b = t.extensions.file_browser.file_browser,
    f = tb.find_files,
    o = tb.oldfiles,
    t = tb.treesitter,
    w = tb.current_buffer_fuzzy_find,
    g = tb.live_grep,
    s = tb.spell_suggest,
    m = tb.man_pages,
    j = ':TodoTelescope<CR>',
    d = ':DevdocsOpenCurrentFloat<CR>'
}) do vim.keymap.set('n', telescope_prefix .. cmd, func) end

-- TODO: add lsp leader shortcuts
