vim.opt.termguicolors = true
vim.opt.showtabline = 2

local tabline_state = {}

local function get_hl(name)
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
    if not ok then
        return {}
    end
    return hl or {}
end

local function to_hex(value)
    if value == nil then
        return nil
    end
    return string.format("#%06x", value)
end

local function hl_fg(name, fallback)
    return to_hex(get_hl(name).fg) or fallback
end

local function hl_bg(name, fallback)
    return to_hex(get_hl(name).bg) or fallback
end

local function setup_tabline_highlights()
    local fallback = {
        fill_bg = "#23283b",
        tab_bg = "#2b3148",
        selected_bg = "#2b3148",
        label_bg = "#263b2d",
        label_fg = "#7dff9b",
        inactive_fg = "#a8b1d1",
        muted_fg = "#7f88aa",
        active_fg = "#6dff8b",
        number_fg = "#7aa2ff",
        modified_fg = "#7dff9b",
        separator_fg = "#3b4261",
        explorer_bg = "#263b2d",
        explorer_fg = "#7dff9b",
    }

    local colors = {
        fill_bg = hl_bg("TabLineFill", fallback.fill_bg),
        tab_bg = hl_bg("TabLine", fallback.tab_bg),
        selected_bg = hl_bg("TabLineSel", fallback.selected_bg),
        label_bg = fallback.label_bg,
        label_fg = fallback.label_fg,
        inactive_fg = fallback.inactive_fg,
        muted_fg = hl_fg("Comment", fallback.muted_fg),
        active_fg = fallback.active_fg,
        number_fg = hl_fg("Directory", fallback.number_fg),
        modified_fg = hl_fg("String", fallback.modified_fg),
        separator_fg = hl_bg("VertSplit", fallback.separator_fg) or fallback.separator_fg,
        explorer_bg = fallback.explorer_bg,
        explorer_fg = fallback.explorer_fg,
    }

    tabline_state.colors = colors

    vim.api.nvim_set_hl(0, "MyTabLineFill", {
        bg = colors.fill_bg,
    })

    vim.api.nvim_set_hl(0, "MyTabLineLabel", {
        fg = colors.label_fg,
        bg = colors.label_bg,
        bold = true,
    })

    vim.api.nvim_set_hl(0, "MyTabLineExplorer", {
        fg = colors.explorer_fg,
        bg = colors.explorer_bg,
        bold = true,
    })

    vim.api.nvim_set_hl(0, "MyTabLineInactive", {
        fg = colors.inactive_fg,
        bg = colors.tab_bg,
    })

    vim.api.nvim_set_hl(0, "MyTabLineActive", {
        fg = colors.active_fg,
        bg = colors.selected_bg,
        bold = true,
    })

    vim.api.nvim_set_hl(0, "MyTabLineNumber", {
        fg = colors.number_fg,
        bg = colors.tab_bg,
        bold = true,
    })

    vim.api.nvim_set_hl(0, "MyTabLineNumberActive", {
        fg = colors.number_fg,
        bg = colors.selected_bg,
        bold = true,
    })

    vim.api.nvim_set_hl(0, "MyTabLineModified", {
        fg = colors.modified_fg,
        bg = colors.tab_bg,
        bold = true,
    })

    vim.api.nvim_set_hl(0, "MyTabLineModifiedActive", {
        fg = colors.modified_fg,
        bg = colors.selected_bg,
        bold = true,
    })

    vim.api.nvim_set_hl(0, "MyTabLineSep", {
        fg = colors.separator_fg,
        bg = colors.fill_bg,
    })
end

local function escape_statusline(text)
    return tostring(text):gsub("%%", "%%%%")
end

local function add(parts, value)
    if value ~= nil then
        parts[#parts + 1] = tostring(value)
    end
end

local function get_buf_name(bufnr)
    local full = vim.api.nvim_buf_get_name(bufnr)
    if full == "" then
        return "[No Name]"
    end

    local tail = vim.fn.fnamemodify(full, ":t")
    if tail == "" then
        return "[No Name]"
    end

    return tail
end

local function get_listed_buffers()
    local result = {}

    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(bufnr)
            and vim.bo[bufnr].buflisted
            and vim.bo[bufnr].filetype ~= "NvimTree"
        then
            table.insert(result, bufnr)
        end
    end

    table.sort(result)
    return result
end

local function get_icon(name)
    local ok, devicons = pcall(require, "nvim-web-devicons")
    if not ok then
        return ""
    end

    local icon = nil
    if type(devicons.get_icon) == "function" then
        icon = select(1, devicons.get_icon(name, nil, { default = false }))
    end

    if icon == nil then
        return ""
    end

    return icon
end

local function find_nvim_tree_width()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local bufnr = vim.api.nvim_win_get_buf(win)
        if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].filetype == "NvimTree" then
            return vim.api.nvim_win_get_width(win)
        end
    end
    return 0
end

function _G.MyTablineSwitchBuffer(minwid)
    if vim.api.nvim_buf_is_valid(minwid) then
        vim.api.nvim_set_current_buf(minwid)
    end
end

function _G.MyCustomTabline()
    local parts = {}
    local current = vim.api.nvim_get_current_buf()
    local buffers = get_listed_buffers()
    local tree_width = find_nvim_tree_width()

    add(parts, "%#MyTabLineFill#")

    if tree_width > 0 then
        local label = " File Explorer "
        local width = math.max(tree_width, #label)
        local pad_total = width - #label
        local left_pad = math.floor(pad_total / 2)
        local right_pad = pad_total - left_pad
        local text = string.rep(" ", left_pad) .. label .. string.rep(" ", right_pad)

        add(parts, "%#MyTabLineExplorer#")
        add(parts, escape_statusline(text))
        add(parts, "%#MyTabLineFill#")
    end

    add(parts, "%#MyTabLineLabel#")
    add(parts, " tabs ")
    add(parts, "%#MyTabLineFill#")

    for i, bufnr in ipairs(buffers) do
        local is_active = bufnr == current
        local name = get_buf_name(bufnr)
        local icon = get_icon(name)
        local modified = vim.bo[bufnr].modified

        local tab_hl = is_active and "%#MyTabLineActive#" or "%#MyTabLineInactive#"
        local number_hl = is_active and "%#MyTabLineNumberActive#" or "%#MyTabLineNumber#"
        local modified_hl = is_active and "%#MyTabLineModifiedActive#" or "%#MyTabLineModified#"

        add(parts, "%" .. bufnr .. "@v:lua.MyTablineSwitchBuffer@")
        add(parts, tab_hl)
        add(parts, " ")
        add(parts, number_hl)
        add(parts, tostring(i))
        add(parts, tab_hl)
        add(parts, " ")

        if icon ~= "" then
            add(parts, escape_statusline(icon))
            add(parts, " ")
        end

        add(parts, escape_statusline(name))

        if modified then
            add(parts, " ")
            add(parts, modified_hl)
            add(parts, "●")
            add(parts, tab_hl)
        end

        add(parts, " ")
        add(parts, "%X")
        add(parts, "%#MyTabLineSep#")
        add(parts, "")
        add(parts, "%#MyTabLineFill#")
    end

    add(parts, "%=")
    add(parts, "%#MyTabLineFill#")

    return table.concat(parts)
end

setup_tabline_highlights()
vim.o.tabline = "%!v:lua.MyCustomTabline()"

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        setup_tabline_highlights()
        vim.cmd("redrawtabline")
    end,
})

vim.api.nvim_create_autocmd({
    "BufAdd",
    "BufDelete",
    "BufModifiedSet",
    "BufEnter",
    "BufWinEnter",
    "BufFilePost",
    "WinEnter",
    "VimResized",
}, {
    callback = function()
        vim.cmd("redrawtabline")
    end,
})
