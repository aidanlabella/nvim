-- Aidan LaBella
-- NeoVim Configuration
-- alabella@brown.edu
--
-- Init File

if vim.iter then
    vim.tbl_flatten = function(tbl)
        return vim.iter(tbl):flatten(math.huge):totable()
    end
end

-- Load all plugins
require('nvim.plugins')

-- Get user settings
S = require('settings')
require('nvim.editor_settings').setup(S)

-- Load all plugin configurations
require('nvim.plugins_config')
