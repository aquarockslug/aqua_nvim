-- AQUA ARCH NEOVIM KEYMAP
local vim = vim -- avoid undefined var warning

vim.keymap.set('n', 'U', "<C-r>") -- undo
vim.keymap.set('n', '<leader>k', ":move-2<CR>==") -- shift line down
vim.keymap.set('n', '<leader>j', ":move+<CR>==") -- shift line up
vim.keymap.set('n', '<leader>h', ':noh<CR>') -- clear highlighting
vim.keymap.set('n', '<leader>t', ':tabnew<CR>')
vim.keymap.set('n', '<leader>e', ':Texplore<CR>')
vim.keymap.set('n', '<leader>nv', ':vnew<CR>')
vim.keymap.set('n', '<leader>nh', ':new<CR>')
-- telescope shortcuts
vim.keymap.set('n', '<leader>fb', ':Telescope file_browser<CR>')
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>')
vim.keymap.set('n', '<leader>fo', ':Telescope oldfiles<CR>')
vim.keymap.set('n', '<leader>ft', ":Telescope treesitter<CR>")
vim.keymap.set('n', '<leader>fw', ":Telescope current_buffer_fuzzy_find<CR>")
vim.keymap.set('n', '<leader>fg', ":Telescope live_grep<CR>")
vim.keymap.set('n', '<leader>fs', ":Telescope spell_suggest<CR>")
vim.keymap.set('n', '<leader>fm', ":Telescope man_pages<CR>")
vim.keymap.set('n', '<leader>ft', ':TodoTelescope<CR>')

-- TODO: add lsp leader shortcuts
