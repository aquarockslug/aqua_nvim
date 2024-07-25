-- AQUA ARCH NEOVIM KEYMAP
local vim = vim -- avoid undefined var warning

vim.keymap.set('n', 'U', '<C-r>') -- undo

-- FUNCTION KEYS
local Terminal = require'toggleterm.terminal'.Terminal
local floater = function(cmd) return Terminal:new({cmd = cmd, direction = 'float'}) end
for cmd, func in pairs({
    [1] = function() floater('lazygit'):toggle() end, -- git
    [2] = ':Neoformat<CR> :w<CR>', -- format
    [3] = function() floater('ddgr --rev'):toggle() end, -- web search
    [4] = function() floater('oil'):toggle() end, -- web bookmarks
    [5] = function() floater('nap'):toggle() end -- notes
}) do vim.keymap.set('n', '<F' .. cmd .. '>', func) end

-- LEADER SHORTCUTS
for cmd, func in pairs({
    h = 'noh<CR>', -- clear highlighting
    j = 'move+<CR>==', -- shift line up
    k = 'move-2<CR>==', -- shift line down
    o = 'Hexplore<CR>', -- open netrw in horizontal pane
    t = 'Texplore<CR>', -- open netrw in new tab
    v = 'Vexplore<CR>' -- open netrw in vertical pane
}) do vim.keymap.set('n', '<leader>' .. cmd, ':' .. func) end

-- TELESCOPE SHORTCUTS
local telescope_prefix = '<leader>f'
local t = require('telescope')
local tb = require('telescope.builtin')
for cmd, func in pairs({
    b = t.extensions.file_browser.file_browser,
    d = ':DevdocsOpenCurrentFloat<CR>',
    f = tb.find_files,
    g = tb.live_grep,
    h = tb.jumplist,
    j = ':TodoTelescope<CR>',
    m = tb.man_pages,
    o = tb.oldfiles,
    s = tb.spell_suggest,
    t = tb.treesitter,
    w = tb.current_buffer_fuzzy_find,
}) do vim.keymap.set('n', telescope_prefix .. cmd, func) end

-- TODO: add lsp leader shortcuts
