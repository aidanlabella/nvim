-- Tabby config
--
--require("config.tabby")

vim.o.showtabline = 2

local config = {
    use_open_file_when_tree_focused = true,
}

local function get_hl(name)
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })

    return ok and hl or {}
end

local function brighten(color, amount)
    local red = math.floor(color / 0x10000) % 0x100
    local green = math.floor(color / 0x100) % 0x100
    local blue = color % 0x100

    red = math.floor(red + (0xff - red) * amount)
    green = math.floor(green + (0xff - green) * amount)
    blue = math.floor(blue + (0xff - blue) * amount)

    return red * 0x10000 + green * 0x100 + blue
end

local function blend(color, target, amount)
    local red = math.floor(color / 0x10000) % 0x100
    local green = math.floor(color / 0x100) % 0x100
    local blue = color % 0x100
    local target_red = math.floor(target / 0x10000) % 0x100
    local target_green = math.floor(target / 0x100) % 0x100
    local target_blue = target % 0x100

    red = math.floor(red + (target_red - red) * amount)
    green = math.floor(green + (target_green - green) * amount)
    blue = math.floor(blue + (target_blue - blue) * amount)

    return red * 0x10000 + green * 0x100 + blue
end

local function setup_tabline_highlights()
    local tabline = get_hl("TabLine")
    local selected = get_hl("TabLineSel")
    local statusline = get_hl("StatusLine")
    local diagnostic_info = get_hl("DiagnosticInfo")
    local string = get_hl("String")
    local diff_add = get_hl("DiffAdd")
    local selected_bg = selected.bg or tabline.bg or statusline.bg or 0x30323d
    local accent = diagnostic_info.fg or string.fg or diff_add.fg or 0x5fb3ff

    vim.api.nvim_set_hl(0, "TabbyTablineFile", {
        fg = tabline.fg or statusline.fg or "#d0d0d0",
        bg = statusline.bg or "#30323d",
    })

    vim.api.nvim_set_hl(0, "TabbyTablineCurrent", {
        fg = selected.fg or tabline.fg or statusline.fg or "#ffffff",
        bg = brighten(selected_bg, 0.18),
        bold = selected.bold,
        italic = selected.italic,
    })

    vim.api.nvim_set_hl(0, "TabbyTablineTail", {
        fg = statusline.bg or tabline.bg or 0x101010,
        bg = blend(accent, selected_bg, 0.18),
        bold = true,
    })
end

local function get_nvim_tree_width()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local bufnr = vim.api.nvim_win_get_buf(win)

        if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].filetype == "NvimTree" then
            return vim.api.nvim_win_get_width(win)
        end
    end

    return 0
end

local function is_nvim_tree_buffer(bufnr)
    return vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].filetype == "NvimTree"
end

local function display_width(text)
    return vim.fn.strdisplaywidth(text)
end

local function center_text(text, width)
    if width <= 0 then
        return ""
    end

    local text_width = display_width(text)

    if width <= text_width then
        return vim.fn.strcharpart(text, 0, width)
    end

    local padding = width - text_width
    local left = math.floor(padding / 2)
    local right = padding - left

    return string.rep(" ", left) .. text .. string.rep(" ", right)
end

local function get_filetype_icon(bufnr)
    local icon = ""
    local ok, devicons = pcall(require, "nvim-web-devicons")

    if ok then
        icon = devicons.get_icon_by_filetype(vim.bo[bufnr].filetype, { default = true }) or icon
    end

    return icon
end

local function get_current_file()
    local bufnr = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(bufnr)
    local filename = name ~= "" and vim.fn.fnamemodify(name, ":t") or "[No Name]"

    return filename .. " " .. get_filetype_icon(bufnr)
end

local function get_tab_file_buffer(tab)
    local current_win = tab.current_win()
    local current_bufnr = vim.api.nvim_win_get_buf(current_win.id)

    if not config.use_open_file_when_tree_focused or not is_nvim_tree_buffer(current_bufnr) then
        return current_bufnr
    end

    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab.id)) do
        local bufnr = vim.api.nvim_win_get_buf(win)

        if vim.api.nvim_buf_is_valid(bufnr) and not is_nvim_tree_buffer(bufnr) then
            return bufnr
        end
    end

    return current_bufnr
end

local function get_buf_label(bufnr, fallback)
    if is_nvim_tree_buffer(bufnr) then
        return fallback
    end

    local name = vim.api.nvim_buf_get_name(bufnr)
    if name == "" then
        return fallback
    end

    return vim.fn.fnamemodify(name, ":t")
end

local function get_tab_label(tab)
    local bufnr = get_tab_file_buffer(tab)

    return get_buf_label(bufnr, tab.name())
end

local function get_tab_icon(tab)
    local bufnr = get_tab_file_buffer(tab)

    return get_filetype_icon(bufnr)
end

setup_tabline_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("TabbyTablineConfig", { clear = true }),
    callback = setup_tabline_highlights,
})

require("tabby.tabline").set(function(line)
    local theme = {
        fill = "TabLineFill",
        head = "TabLine",
        current_tab = "TabbyTablineCurrent",
        tab = "TabLine",
        file = "TabbyTablineFile",
        tail = "TabbyTablineTail",
    }

    local current_tabnr = vim.api.nvim_tabpage_get_number(line.api.get_current_tab())
    local tab_count = #vim.api.nvim_list_tabpages()
    local first_tab_hl = current_tabnr == 1 and theme.current_tab or theme.tab
    local tree_width = get_nvim_tree_width()
    local head_sep = ""
    local tree_label_width = math.max(tree_width - display_width(head_sep), 0)
    local tree_label = tree_width > 0 and center_text("Project Tree", tree_label_width) or nil

    return {
        tree_label and {
            tree_label,
            hl = theme.head,
        } or {
            " tabs ",
            hl = theme.head,
        },
        line.sep(head_sep, theme.head, first_tab_hl),
        line.tabs().foreach(function(tab, index, tab_count)
            local is_current = tab.is_current()
            local hl = is_current and theme.current_tab or theme.tab
            local next_hl = index + 1 == current_tabnr and theme.current_tab or theme.tab

            if index == tab_count then
                next_hl = theme.fill
            end

            return {
                {
                    " " .. tab.number() .. ": " .. get_tab_label(tab) .. " " .. get_tab_icon(tab) .. " ",
                    hl = hl,
                },
                line.sep("", hl, next_hl),
                hl = hl,
            }
        end),
        line.spacer(),
        line.sep("", theme.file, theme.fill),
        {
            " " .. get_current_file() .. " ",
            hl = theme.file,
        },
        line.sep("", theme.tail, theme.file),
        {
            " Tab " .. current_tabnr .. "/" .. tab_count .. " ",
            hl = theme.tail,
        },
        hl = theme.fill,
    }
end)
