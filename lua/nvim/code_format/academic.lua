-- Aidan LaBella
-- NeoVim Configuration
-- alabella@brown.edu
--
-- Academic Formatting

vim.api.nvim_exec(
[[
    set tabstop=4
    set shiftwidth=4
]],
false)

-- For Brown courses that require 2 space tabs
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.tabstop = 2
        vim.bo.softtabstop = 2
        vim.bo.expandtab = true -- Ensures spaces are used instead of tabs
    end,
})
