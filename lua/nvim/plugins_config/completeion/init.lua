local coq_settings = {
    auto_start = "shut-up",
    display = {
        icons = {
            mode = "long",
            spacing = 1,
        },
        pum = {
            fast_close = false,
            kind_context = { " ", "" },
            source_context = { " ", "" },
        },
        ghost_text = {
            enabled = true,
            highlight_group = "Comment",
        },
        preview = {
            border = "rounded",
        },
    },
}

vim.g.coq_settings = vim.tbl_deep_extend("force", vim.g.coq_settings or {}, coq_settings)

local function get_hl(name)
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })

    return ok and hl or {}
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

local function setup_completion_highlights()
    local normal = get_hl("Normal")
    local cursor_line = get_hl("CursorLine")
    local visual = get_hl("Visual")
    local info = get_hl("DiagnosticInfo")
    local hint = get_hl("DiagnosticHint")
    local warn = get_hl("DiagnosticWarn")
    local error = get_hl("DiagnosticError")
    local string = get_hl("String")
    local func = get_hl("Function")
    local type = get_hl("Type")
    local keyword = get_hl("Keyword")
    local constant = get_hl("Constant")
    local property = get_hl("@property")
    local variable = get_hl("@variable")
    local comment = get_hl("Comment")

    local bg = normal.bg or 0x1e1e2e
    local fg = normal.fg or 0xcdd6f4
    local menu_bg = blend(bg, 0x000000, 0.12)
    local select_bg = visual.bg or cursor_line.bg or blend(bg, info.fg or 0x89b4fa, 0.28)
    local blue = info.fg or 0x89b4fa
    local cyan = hint.fg or 0x94e2d5
    local yellow = warn.fg or 0xf9e2af
    local red = error.fg or 0xf38ba8
    local green = string.fg or 0xa6e3a1
    local purple = type.fg or 0xcba6f7
    local peach = constant.fg or 0xfab387
    local mauve = keyword.fg or 0xcba6f7
    local property_fg = property.fg or 0x89dceb
    local variable_fg = variable.fg or fg
    local muted = comment.fg or blend(fg, bg, 0.45)

    vim.api.nvim_set_hl(0, "Pmenu", { fg = fg, bg = menu_bg })
    vim.api.nvim_set_hl(0, "PmenuSel", { fg = fg, bg = select_bg, bold = true })
    vim.api.nvim_set_hl(0, "PmenuKind", { fg = blue, bg = menu_bg })
    vim.api.nvim_set_hl(0, "PmenuKindSel", { fg = blue, bg = select_bg, bold = true })
    vim.api.nvim_set_hl(0, "PmenuExtra", { fg = muted, bg = menu_bg })
    vim.api.nvim_set_hl(0, "PmenuExtraSel", { fg = muted, bg = select_bg })
    vim.api.nvim_set_hl(0, "PmenuSbar", { bg = blend(menu_bg, fg, 0.12) })
    vim.api.nvim_set_hl(0, "PmenuThumb", { bg = blue })

    vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = variable_fg })
    vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = blue })
    vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = func.fg or blue })
    vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = peach })
    vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = property_fg })
    vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = variable_fg })
    vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = purple })
    vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = purple })
    vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = cyan })
    vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = property_fg })
    vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = yellow })
    vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = peach })
    vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = purple })
    vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = mauve })
    vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = green })
    vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = red })
    vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = cyan })
    vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = red })
    vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = cyan })
    vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = peach })
    vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = constant.fg or peach })
    vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = purple })
    vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = yellow })
    vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = mauve })
    vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = purple })
end

setup_completion_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("CoqCompletionHighlights", { clear = true }),
    callback = setup_completion_highlights,
})

local completion_kinds = {
    "TypeParameter",
    "EnumMember",
    "Constructor",
    "Interface",
    "Reference",
    "Parameter",
    "Constant",
    "Function",
    "Property",
    "Variable",
    "Operator",
    "Keyword",
    "Snippet",
    "Folder",
    "Method",
    "Module",
    "Struct",
    "Value",
    "Class",
    "Color",
    "Event",
    "Field",
    "Enum",
    "File",
    "Text",
    "Unit",
    "Type",
}

local kind_highlight_aliases = {
    Parameter = "Variable",
    Type = "Class",
}

local function coq_kind_hlgroup(kind)
    return "CmpItemKind" .. (kind_highlight_aliases[kind] or kind)
end

local function split_coq_kind(abbr)
    if type(abbr) ~= "string" then
        return nil, nil, nil
    end

    for _, kind in ipairs(completion_kinds) do
        local start_at = abbr:find("%s+%S+%s+" .. kind .. "$")

        if start_at then
            local label = abbr:sub(1, start_at - 1):gsub("%s+$", "")
            local kind_label = abbr:sub(start_at + 1):match("^%s*(.-)%s*$")

            return label, kind_label, kind
        end
    end

    return nil, nil, nil
end

local function apply_coq_kind_highlights(items)
    if type(items) ~= "table" then
        return
    end

    for _, item in ipairs(items) do
        if type(item) == "table" then
            local label, kind_label, kind = split_coq_kind(item.abbr)

            if label and kind_label and kind then
                item.abbr = label
                item.kind = kind_label
                item.kind_hlgroup = coq_kind_hlgroup(kind)
            elseif type(item.kind) == "string" and item.kind ~= "" then
                local kind_name = item.kind:match("([%a_]+)$")

                if kind_name then
                    item.kind_hlgroup = coq_kind_hlgroup(kind_name)
                end
            end
        end
    end
end

local function patch_coq_completion()
    if not _G.COQ or type(_G.COQ.send_comp) ~= "function" or _G.COQ.__kind_hl_patched then
        return false
    end

    local original_send_comp = _G.COQ.send_comp

    _G.COQ.send_comp = function(col, items)
        apply_coq_kind_highlights(items)

        return original_send_comp(col, items)
    end

    _G.COQ.__kind_hl_patched = true

    return true
end

local function schedule_coq_patch(attempt)
    if patch_coq_completion() or attempt >= 40 then
        return
    end

    vim.defer_fn(function()
        schedule_coq_patch(attempt + 1)
    end, 100)
end

schedule_coq_patch(1)

vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("CoqCompletionKindHighlights", { clear = true }),
    pattern = "COQ*",
    callback = function()
        schedule_coq_patch(1)
    end,
})
