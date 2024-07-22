-- AQUA ARCH NEOVIM KEYMAP
local vim = vim -- avoid undefined var warning

-- leader commands
for cmd, func in pairs({
    U = '<C-r>', -- undo
    k = ':move-2<CR>==', -- shift line down
    j = ':move+<CR>==', -- shift line up
    h = ':noh<CR>', -- clear highlighting
    t = ':Texplore<CR>', -- open netrw in new tab
    ph = ':Hexplore<CR>', -- open netrw in horizontal pane
    pv = ':Vexplore<CR>' -- open netrw in vertical pane
}) do vim.keymap.set('n', '<leader>' .. cmd, func) end

-- telescope commands
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
