local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
  { key = "s",                        cb = tree_cb("vsplit") },
  { key = "v",                        cb = tree_cb("split") },
  { key = "t",                        cb = tree_cb("tabnew") },
}

vim.api.nvim_exec(
[[
    set fillchars=vert:\  
    let g:nvim_tree_width = 35 "30 by default
    let g:nvim_tree_quit_on_open = 0 "0 by default, closes the tree when you open a file
    let g:nvim_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
    let g:nvim_tree_git_hl = 1
    let g:nvim_tree_lsp_diagnostics = 1
    let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
    let g:nvim_tree_disable_netrw = 0
    let g:nvim_tree_tab_open = 1


]],
false)

vim.g.nvim_tree_icons = {
    default = '',
    symlink = '',
    git = {
        unstaged = "✗",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "★",
        deleted = "",
        ignored = "◌"
    },
    folder = {
        arrow_open = "",
        arrow_closed = "",
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
        symlink_open = "",
    },
    lsp = {
        hint = "",
        info = "",
        warning = "",
        error = "",
    }
}

-- Custom Folder Icon Hi Link
vim.cmd[[highlight NvimTreeFolderIcon guifg='#c09553']]

local tree ={}
treeState = false

tree.open = function ()
   require'bufferline.state'.set_offset(35, 'FileTree')
   require'nvim-tree'.find_file(true)
   treeState=true
end

tree.close = function ()
   require'bufferline.state'.set_offset(0)
   require'nvim-tree'.close()
   treeState=false
end

tree.toggle = function ()
    if treeState then
        tree.close()
    else
        tree.open()
    end
end

return tree
