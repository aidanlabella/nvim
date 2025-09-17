-- myneovim configruation files
-- Author: Aidan LaBella - Brown University Department of Computer Science
-- Email: alabella@brown.edu 
-- 
-- Module: plugins-config
-- Plugin configuration

local mod_prefix = "nvim/plugins_config/"
vim.hl = vim.highlight

-- Plugins that require a global declaration
nvimTree = require(mod_prefix .. 'file-tree')

-- Plugins requiring lua initailization with DEFAULT options
require('colorizer').setup()
require('nvim-autopairs').setup()
require('neoscroll').setup()
require('lsp_signature').setup()
require('gitsigns').setup()
require('neogen').setup()
require('git-conflict').setup()
require("glow").setup()

-- Plugins with lua initailization with custom options
require(mod_prefix .. 'completeion')
require(mod_prefix .. 'dashboard')
require(mod_prefix .. 'commenter')
require(mod_prefix .. 'lsp')
require(mod_prefix .. 'statusline')
require(mod_prefix .. 'treesitter')
require(mod_prefix .. 'whichkey')
require(mod_prefix .. 'trouble_diag')
--require(mod_prefix .. 'indent_line')
require(mod_prefix .. 'cursorline')
require(mod_prefix .. 'tabline')
--For NVIM 0.8
require(mod_prefix .. 'splash')
require(mod_prefix .. 'dropbar')

-- Plugins using vimscript
require(mod_prefix .. 'code-minimap')
require(mod_prefix .. 'ranger')
require(mod_prefix .. 'latex')
