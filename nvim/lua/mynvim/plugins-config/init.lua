-- myneovim configruation files
-- Author: Aidan LaBella - RIT Department of Computer Science
-- Email: apl1341@cs.rit.edu 
-- 
-- Module: plugins-config
-- Plugin configuration

--local home = os.getenv( "HOME" )
--local nvim_conf_dir = "/.config/nvim/lua"
local mod_prefix = "mynvim/plugins-config/"
--
-- Plugins that require a global declaration
nvimTree = require(mod_prefix .. 'file-tree')
--neogit = require("neogit")

-- Plugins requiring lua initailization
require('colorizer').setup()
require('nvim-autopairs').setup()
require('neoscroll').setup()
require('lsp_signature').setup()


require(mod_prefix .. 'completeion')
require(mod_prefix .. 'lsp')
require(mod_prefix .. 'statusline')
require(mod_prefix .. 'treesitter')
require(mod_prefix .. 'whichkey')
require(mod_prefix .. 'trouble_diag')
require(mod_prefix .. 'indent_line')

-- Plugins using vimscript
require(mod_prefix .. 'code-minimap')
require(mod_prefix .. 'ranger')
require(mod_prefix .. 'tabline')
require(mod_prefix .. 'bullets')
