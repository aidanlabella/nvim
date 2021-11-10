require('bufferline').setup {
    options = {
        numbers = "ordinal",
        separator_style = "thin",
        offsets = {{filetype = "NvimTree", text = "File Explorer" , text_align = "left"}},
        diagnostics =  "nvim_lsp",
        modified_icon = ' '
    }
}
