-- tabline.lua
-- Airline-style tabline with powerline arrow separators.
-- Drop this in your Neovim config and source it, or require() it from init.lua.

vim.opt.termguicolors = true
vim.opt.showtabline = 2

-- Powerline separators
local SEP_RIGHT = "\u{E0B0}"
local SEP_LEFT  = "\u{E0B2}"
local SEP_THIN  = "\u{E0B1}"

local tabline_state = {}

-- ─── Color helpers ────────────────────────────────────────────────────────────

local function get_hl(name)
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
    return (ok and hl) or {}
end

local function to_hex(value)
    if not value then return nil end
    return string.format("#%06x", value)
end

local function hl_fg(name, fallback)
    return to_hex(get_hl(name).fg) or fallback
end

local function hl_bg(name, fallback)
    return to_hex(get_hl(name).bg) or fallback
end

-- ─── Highlight setup ──────────────────────────────────────────────────────────

local function setup_tabline_highlights()
    -- Pull as much as possible from the active colorscheme.
    -- These fallbacks only fire if a highlight group is completely missing.
    local fill_bg     = hl_bg("TabLineFill", "#1a1b26")
    local tab_bg      = hl_bg("TabLine",     "#24283b")
    local selected_bg = hl_bg("TabLineSel",  "#2e3350")
    local inactive_fg = hl_fg("TabLine",     "#7982a9")
    local active_fg   = hl_fg("TabLineSel",  "#c0caf5")
    local number_fg   = hl_fg("Special",     "#7aa2ff")
    local modified_fg = hl_fg("String",      "#9ece6a")
    local label_bg    = hl_bg("StatusLine",  "#16161e")
    local label_fg    = hl_fg("Function",    "#7dcfff")
    local comment_fg  = hl_fg("Comment",     "#565f89")

    tabline_state.colors = {
        fill_bg     = fill_bg,
        tab_bg      = tab_bg,
        selected_bg = selected_bg,
        inactive_fg = inactive_fg,
        active_fg   = active_fg,
        label_bg    = label_bg,
        label_fg    = label_fg,
    }

    -- Fill / background
    vim.api.nvim_set_hl(0, "TL_Fill",        { bg = fill_bg })

    -- Label segment (far left, e.g. "BUFFERS")
    vim.api.nvim_set_hl(0, "TL_Label",       { fg = label_fg, bg = label_bg, bold = true })
    -- Arrow from label to fill
    vim.api.nvim_set_hl(0, "TL_LabelSep",    { fg = label_bg, bg = fill_bg })

    -- Inactive tab body
    vim.api.nvim_set_hl(0, "TL_Inactive",    { fg = inactive_fg, bg = tab_bg })
    vim.api.nvim_set_hl(0, "TL_InactiveNum", { fg = number_fg,   bg = tab_bg,      bold = true })
    vim.api.nvim_set_hl(0, "TL_InactiveMod", { fg = modified_fg, bg = tab_bg,      bold = true })
    -- Arrow from inactive tab to fill
    vim.api.nvim_set_hl(0, "TL_InactiveSep", { fg = tab_bg,      bg = fill_bg })
    -- Thin separator between adjacent inactive tabs
    vim.api.nvim_set_hl(0, "TL_ThinSep",     { fg = comment_fg,  bg = tab_bg })

    -- Active tab body
    vim.api.nvim_set_hl(0, "TL_Active",      { fg = active_fg,   bg = selected_bg, bold = true })
    vim.api.nvim_set_hl(0, "TL_ActiveNum",   { fg = number_fg,   bg = selected_bg, bold = true })
    vim.api.nvim_set_hl(0, "TL_ActiveMod",   { fg = modified_fg, bg = selected_bg, bold = true })
    -- Left arrow INTO active tab (fill → selected)
    vim.api.nvim_set_hl(0, "TL_ActiveSepL",  { fg = selected_bg, bg = fill_bg })
    -- Right arrow OUT of active tab (selected → fill)
    vim.api.nvim_set_hl(0, "TL_ActiveSepR",  { fg = selected_bg, bg = fill_bg })
    -- Transition from inactive → active
    vim.api.nvim_set_hl(0, "TL_ToActive",    { fg = tab_bg,      bg = selected_bg })
    -- Transition from active → inactive
    vim.api.nvim_set_hl(0, "TL_FromActive",  { fg = selected_bg, bg = tab_bg })
end

-- ─── Buffer helpers ───────────────────────────────────────────────────────────

local function escape_sl(text)
    return tostring(text):gsub("%%", "%%%%")
end

local function add(parts, value)
    if value ~= nil then
        parts[#parts + 1] = tostring(value)
    end
end

local function get_buf_name(bufnr)
    local full = vim.api.nvim_buf_get_name(bufnr)
    if full == "" then return "[No Name]" end
    local tail = vim.fn.fnamemodify(full, ":t")
    return (tail ~= "") and tail or "[No Name]"
end

local function get_listed_buffers()
    local result = {}
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if  vim.api.nvim_buf_is_valid(bufnr)
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
    if not ok then return "" end
    local icon = select(1, devicons.get_icon(name, nil, { default = false }))
    return icon or ""
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

-- ─── Click handler ────────────────────────────────────────────────────────────

function _G.MyTablineSwitchBuffer(minwid)
    if vim.api.nvim_buf_is_valid(minwid) then
        vim.api.nvim_set_current_buf(minwid)
    end
end

-- ─── Tabline renderer ─────────────────────────────────────────────────────────

function _G.MyCustomTabline()
    local parts   = {}
    local current = vim.api.nvim_get_current_buf()
    local buffers = get_listed_buffers()
    local n       = #buffers

    add(parts, "%#TL_Fill#")

    -- NvimTree label (mirrors its window width)
    local tree_width = find_nvim_tree_width()
    if tree_width > 0 then
        local label     = " 󰙅 Explorer "
        local width     = math.max(tree_width, #label)
        local pad_total = width - #label
        local lpad      = math.floor(pad_total / 2)
        local rpad      = pad_total - lpad
        local text      = string.rep(" ", lpad) .. label .. string.rep(" ", rpad)

        add(parts, "%#TL_Label#")
        add(parts, escape_sl(text))
        add(parts, "%#TL_LabelSep#")
        add(parts, SEP_RIGHT)
        add(parts, "%#TL_Fill#")
        add(parts, " ")
    end

    -- Buffer list
    for i, bufnr in ipairs(buffers) do
        local is_active  = bufnr == current
        local prev_bufnr = buffers[i - 1]
        local prev_active = prev_bufnr and (prev_bufnr == current)
        local name       = get_buf_name(bufnr)
        local icon       = get_icon(name)
        local modified   = vim.bo[bufnr].modified

        -- ── Leading arrow / separator ──────────────────────────────────────
        if is_active then
            if prev_active then
                -- shouldn't happen, but guard anyway
                add(parts, "%#TL_ActiveSepL#")
                add(parts, SEP_RIGHT)
            elseif prev_bufnr then
                -- inactive → active: arrow colour blends tab_bg → selected_bg
                add(parts, "%#TL_ToActive#")
                add(parts, SEP_RIGHT)
            else
                -- very first tab and it's active
                add(parts, "%#TL_ActiveSepL#")
                add(parts, SEP_RIGHT)
            end
        else
            if i > 1 and not prev_active then
                -- inactive → inactive: thin separator inside the tab body
                add(parts, "%#TL_ThinSep#")
                add(parts, SEP_THIN)
            elseif prev_active then
                -- active → inactive: arrow out of active tab
                add(parts, "%#TL_FromActive#")
                add(parts, SEP_RIGHT)
            else
                -- first tab, inactive
                -- no leading arrow needed; fill is already the background
            end
        end

        -- ── Tab body ───────────────────────────────────────────────────────
        local body_hl  = is_active and "%#TL_Active#"    or "%#TL_Inactive#"
        local num_hl   = is_active and "%#TL_ActiveNum#" or "%#TL_InactiveNum#"
        local mod_hl   = is_active and "%#TL_ActiveMod#" or "%#TL_InactiveMod#"

        add(parts, "%" .. bufnr .. "@v:lua.MyTablineSwitchBuffer@")
        add(parts, body_hl)
        add(parts, " ")
        add(parts, num_hl)
        add(parts, tostring(i))
        add(parts, body_hl)
        add(parts, " ")

        if icon ~= "" then
            add(parts, escape_sl(icon))
            add(parts, " ")
        end

        add(parts, escape_sl(name))

        if modified then
            add(parts, " ")
            add(parts, mod_hl)
            add(parts, "●")
        end

        add(parts, body_hl)
        add(parts, " ")
        add(parts, "%X")

        -- ── Trailing arrow (last tab only, or active tab) ──────────────────
        if i == n then
            if is_active then
                add(parts, "%#TL_ActiveSepR#")
            else
                add(parts, "%#TL_InactiveSep#")
            end
            add(parts, SEP_RIGHT)
            add(parts, "%#TL_Fill#")
        end
    end

    -- Right-align spacer
    add(parts, "%=")
    add(parts, "%#TL_Fill#")

    return table.concat(parts)
end

-- ─── Wire it up ───────────────────────────────────────────────────────────────

setup_tabline_highlights()
vim.o.tabline = "%!v:lua.MyCustomTabline()"

-- Re-derive colors whenever the colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        setup_tabline_highlights()
        vim.cmd("redrawtabline")
    end,
})

-- Redraw on any buffer/window change
vim.api.nvim_create_autocmd({
    "BufAdd", "BufDelete", "BufModifiedSet", "BufEnter",
    "BufWinEnter", "BufFilePost", "WinEnter", "VimResized",
}, {
    callback = function()
        vim.cmd("redrawtabline")
    end,
})
