require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
      width = 35,
    },
    tab = {
      sync = {
        open = true,
        close = true,
      },
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
})

vim.api.nvim_exec([[set fillchars+=vert:\ ]], false)
