--local neogit = require('neogit')
--neogit.setup {}
CONFIG_PATH = vim.fn.stdpath('config')

vim.cmd('source '..CONFIG_PATH..'/plugins/plugins.vim')
require('plugins')

vim.cmd('source '..CONFIG_PATH..'/general/editor.vim')
vim.cmd('source '..CONFIG_PATH..'/general/theme.vim')
vim.cmd('source '..CONFIG_PATH..'/keybindings/keys.vim')
vim.cmd('source '..CONFIG_PATH..'/markup/general.vim')
vim.cmd('source '..CONFIG_PATH..'/plugins/settings.vim')
