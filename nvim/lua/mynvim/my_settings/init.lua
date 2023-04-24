-- Most color schemes will be able to be set here
-- Some may require more config options (see below)

-- Other colorscheme-options that are global variables can be set here:
--vim.g.dracula_italic_comment = true

-- this may be required for other colorschemes (i.e. onedark)
-- Un-comment if you plan to use a theme besides dracula that
-- has specific neovim/tresitter features

 require('onedark').setup{
     style = 'darker',
     transparent = true,
     term_colors = true,
     code_style = {
         functions = 'italic',
         keywords = 'none',
         comments = 'bold',
         functions = 'italic',
         strings = 'bold',
     },
 
 }
--

vim.api.nvim_exec(
[[
    colorscheme onedark
]],
false)

 require('onedark').load()
