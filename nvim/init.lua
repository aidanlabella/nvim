--local neogit = require('neogit')
--neogit.setup {}
CONFIG_PATH = vim.fn.stdpath('config')

require('mynvim.plugins')
require('mynvim.editor_settings')
require('mynvim.plugins-config')

-- Code formatting options 
-- Change me to the format spec needed!
require('mynvim.code-format.rit')
