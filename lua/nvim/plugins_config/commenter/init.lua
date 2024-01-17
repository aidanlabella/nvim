require('Comment').setup({
    padding = true,
    sticky = true,
    ignore = nil,
    toggler = { line = '<Space>cc', block = '<Space>bc' },
    opleader = { line = '<Space>c', block = '<Space>b' },
    extra = { above = '<Space>cO', below = '<Space>co', eol = '<Space>cA' },
    mappings = { basic = true, extra = true },
    pre_hook = nil,
    post_hook = nil,
})
