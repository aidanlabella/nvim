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
