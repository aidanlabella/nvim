-- Most color schemes will be able to be set here
-- Some may require more config options (see below)
vim.api.nvim_exec(
[[
    colorscheme dracula
]],
false)

-- Other colorscheme-options that are global variables can be set here:
vim.g.dracula_italic_comment = true

-- this may be required for other colorschemes (i.e. onedark)
-- Un-comment if you plan to use a theme besides dracula that
-- has specific neovim/tresitter features

-- require('onedark').setup{
--     style = 'deep',
--     code_style = {
--         functions = 'bold,italic',
--         comments = 'none',
--     },
-- 
-- }
-- require('onedark').load()
