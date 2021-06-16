--local neogit = require('neogit')
--neogit.setup {}
CONFIG_PATH = vim.fn.stdpath('config')

require('plugins')

vim.cmd('source '..CONFIG_PATH..'/general/editor.vim')
vim.cmd('source '..CONFIG_PATH..'/general/theme.vim')
vim.cmd('source '..CONFIG_PATH..'/markup/general.vim')
require('plugged')
vim.cmd('source '..CONFIG_PATH..'/plugins/settings.vim')
