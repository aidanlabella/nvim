--local neogit = require('neogit')
--neogit.setup {}
CONFIG_PATH = vim.fn.stdpath('config')

require('plugins')
require('editor_settings')
require('plugins-config')
