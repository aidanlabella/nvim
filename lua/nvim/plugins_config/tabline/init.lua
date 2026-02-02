vim.opt.termguicolors = true
vim.opt.showtabline = 2

vim.g.barbar_auto_setup = false

require("barbar").setup({
    animation = false,
    auto_hide = false,
    clickable = false,
    tabpages = true,

    maximum_padding = 1,
    minimum_padding = 1,
    maximum_length = 30,

    icons = {
        buffer_index = true,
        buffer_number = false,

        -- Powerline-style arrows (needs Nerd Font / powerline glyph support)
        separator = { left = "", right = "" },
        separator_at_end = true,

        -- Clean blocks
        button = "",
        modified = { button = "●" },
        filetype = { enabled = true },
    },

    sidebar_filetypes = {
        NvimTree = {
            text = "File Explorer",
            align = "left",
        },
    },
})

-- Make the arrows actually look like arrows by giving the separator a bg->bg transition.
-- These links usually work well across themes. If your theme has weak TabLine colors,
-- you can explicitly set bg/fg after this.
vim.cmd("hi! link BufferCurrent TabLineSel")
vim.cmd("hi! link BufferVisible TabLine")
vim.cmd("hi! link BufferInactive TabLine")
vim.cmd("hi! link BufferTabpageFill TabLineFill")
vim.cmd("hi! link BufferTabpages TabLine")

-- Crucial: the separator itself uses *Sign* highlight groups in barbar.
-- Linking them makes the arrow glyph render with the right transition colors.
vim.cmd("hi! link BufferCurrentSign TabLineSel")
vim.cmd("hi! link BufferVisibleSign TabLine")
vim.cmd("hi! link BufferInactiveSign TabLine")

-- Also keep indices consistent
vim.cmd("hi! link BufferCurrentIndex TabLineSel")
vim.cmd("hi! link BufferVisibleIndex TabLine")
vim.cmd("hi! link BufferInactiveIndex TabLine")
