local vim = vim
require('telescope').setup()
require("nvim-treesitter").setup()
require('markdown').setup()
require("nvim-devdocs").setup()
-- require('dap-python').setup('/usr/bin/python')
-- require('dapui').setup()
require('Comment').setup()
require("startup").setup({theme = "dashboard"})
require('glow').setup({
	width_ratio = 1,
	height_ratio = 1,
})
require("toggleterm").setup{
	shade_terminals = true,
	float_opts = {
		border = 'curved',
		height = 5,
	}
}
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	direction = "float",
	float_opts = {
		border = 'double',
		height = 40
	},
	hidden = true,
})
function _lazygit() lazygit:toggle() end
require("autoclose").setup({
   keys = {
      ["("] = { escape = false, close = true, pair = "()" },
      ["["] = { escape = false, close = true, pair = "[]" },
      ["{"] = { escape = false, close = true, pair = "{}" },

      [">"] = { escape = true, close = false, pair = "<>" },
      [")"] = { escape = true, close = false, pair = "()" },
      ["]"] = { escape = true, close = false, pair = "[]" },
      ["}"] = { escape = true, close = false, pair = "{}" },

      ['"'] = { escape = true, close = true, pair = '""' },
      ["'"] = { escape = true, close = true, pair = "''" },
      ["`"] = { escape = true, close = true, pair = "``" },
   },
   options = {
      disabled_filetypes = { "text" },
      disable_when_touch = false,
      touch_regex = "[%w(%[{]",
      pair_spaces = false,
      auto_indent = true,
   },
})

-- linting
require('lint').linters_by_ft = {
  python = {'pylint'},
  javascript = {'eslint'},
  typescript = {'typescript-language-server'},
  json = {'jsonlint'},
  markdown = {'vale'},
  lua = {'luacheck'}
}
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function() require("lint").try_lint() end,
})

-- search
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
