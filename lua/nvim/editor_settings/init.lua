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

    vim.cmd('colorscheme ' .. opts.colorscheme)

    if opts.autoindent then
        vim.cmd('set autoindent')
    end

    require('nvim.code_format.' .. opts.formatting)

end

return M
