--vim.g.vimtex_view_general_viewer = 'evince'
if vim.loop.os_uname().sysname == "Linux" then
    -- Okular/XPdf (Linux)
    vim.g.vimtex_view_general_viewer = 'okular' -- the space at the end is important!
else
    -- Preview (MacOS:)
    vim.g.vimtex_view_general_viewer = 'open -a skim ' -- the space at the end is important!
end
