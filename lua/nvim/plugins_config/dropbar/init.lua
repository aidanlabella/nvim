local dropbar = require('dropbar')
local dropbar_api = require('dropbar.api')

vim.ui.select = require('dropbar.utils.menu').select
vim.api.nvim_set_hl(0, "WinBar", { link = "TelescopePreviewSticky" })
