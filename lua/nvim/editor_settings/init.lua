-- Aidan LaBella
-- NeoVim Configuration
-- alabella@brown.edu
--
-- Editor Settings

local M = {}

function M.setup(opts)
    -- Color Scheme
    vim.api.nvim_exec(
    [[
        
        set expandtab
        set laststatus=2
        set hidden
        set mouse=a
        set number

        cnoreabbrev W w
        cnoreabbrev Q q
        cnoreabbrev X q

        " leader timeout
        set updatetime=300
        set timeoutlen=250

        set termguicolors
    ]],
    false)


    if opts.autoindent then
        vim.cmd('set autoindent')
    end

    require('nvim.code_format.' .. opts.formatting)

    if opts.colorscheme == 'onedark' then
        require('onedark').setup{
             style = 'deep',
             transparent = true,
             term_colors = true,
             code_style = {
                 functions = 'none',
                 keywords = 'italic',
                 comments = 'bold',
                 strings = 'bold',
            },
        }
    end

    vim.cmd('colorscheme ' .. opts.colorscheme)

end

return M
