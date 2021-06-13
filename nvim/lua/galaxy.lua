--   ____       _                  _     _
--  / ___| __ _| | __ ___  ___   _| |   (_)_ __   ___
-- | |  _ / _` | |/ _` \ \/ | | | | |   | | '_ \ / _ \
-- | |_| | (_| | | (_| |>  <| |_| | |___| | | | |  __/
--  \____|\__,_|_|\__,_/_/\_\\__, |_____|_|_| |_|\___|
--                           |___/
-- See: https://github.com/glepnir/galaxyline.nvim

-- Configuration {{{1

-- Imports {{{2
local gl = require('galaxyline')
local condition = require('galaxyline.condition')
-- }}}2

-- Functions {{{2
local function u(code)
    if type(code) == 'string' then
        code = tonumber('0x' .. code)
    end
    local c = string.char
    if code <= 0x7f then
        return c(code)
    end
    local t = {}

    if code <= 0x07ff then
        t[1] = c(bit.bor(0xc0, bit.rshift(code, 6)))
        t[2] = c(bit.bor(0x80, bit.band(code, 0x3f)))
    elseif code <= 0xffff then
        t[1] = c(bit.bor(0xe0, bit.rshift(code, 12)))
        t[2] = c(bit.bor(0x80, bit.band(bit.rshift(code, 6), 0x3f)))
        t[3] = c(bit.bor(0x80, bit.band(code, 0x3f)))
    else
        t[1] = c(bit.bor(0xf0, bit.rshift(code, 18)))
        t[2] = c(bit.bor(0x80, bit.band(bit.rshift(code, 12), 0x3f)))
        t[3] = c(bit.bor(0x80, bit.band(bit.rshift(code, 6), 0x3f)))
        t[4] = c(bit.bor(0x80, bit.band(code, 0x3f)))
    end

    return table.concat(t)
end

local function highlight(group, fg, bg, gui)
    local cmd = string.format('highlight %s guifg=%s guibg=%s', group, fg, bg)

    if gui ~= nil then
        cmd = cmd .. ' gui=' .. gui
    end

    vim.cmd(cmd)
end

-- }}}2

-- Settings {{{2
local lineLengthWarning = 80
local lineLengthError = 120
local leftbracket = "" -- Curve.
local rightbracket = "" -- Curve.
-- local leftbracket = u 'e0b2' -- Angle filled.
-- local rightbracket = u 'e0b0' -- Angle filled.
-- local leftbracket = u 'e0b3' -- Angle.
-- local rightbracket = u 'e0b1' -- Angle.
gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'packer', 'tagbar'}
local gls = gl.section
-- }}}2

-- Colours, maps and icons {{{2
local colors = {
    bg              = '#44475a',

    giticon         = '#6272a4',
    gitbg           = '#44475a',
    gittext         = '#ff5555',

    diagerror       = '#F44747',
    diagwarn        = '#ffb86c',
    diaghint        = '#4FC1FF',
    diaginfo        = '#FFCC66',

    lspicon         = '#6272a4',
    lspbg           = '#44475a',
    lsptext         = '#C5C5C5',

    typeicon        = '#50fa7b',
    typebg          = '#282a36',
    typetext        = '#C5C5C5',

    statsicon       = '#9CDCFE',
    statsbg         = '#5080A0',
    statstext       = '#000000',

    lineokfg        = '#000000',
    lineokbg        = '#5080A0',
    linelongerrorfg = '#FF0000',
    linelongwarnfg  = '#FFFF00',
    linelongbg      = '#5080A0',

    shortbg         = '#DCDCAA',
    shorttext       = '#000000',

    shortrightbg    = '#3F3F3F',
    shortrighttext  = '#7C4C4E',

    red             = '#D16969',
    yellow          = '#DCDCAA',
    magenta         = '#D16D9E',
    green           = '#608B4E',
    orange          = '#ffb86c',
    purple          = '#C586C0',
    blue            = '#569CD6',
    cyan            = '#4EC9B0'
}

local mode_map = {
    ['n']        = {'#bd93f9', 'NORMAL'},
    ['i']        = {'#50fa7b', 'INSERT'},
    ['R']        = {'#50fa7b', 'REPLACE'},
    ['c']        = {'#ff79c6', 'COMMAND'},
    ['v']        = {'#bd93f9', 'VISUAL'},
    ['V']        = {'#bd93f9', 'VIS-LN'},
    ['']       = {'#bd93f9', 'VIS-BLK'},
    ['s']        = {'#ffb86c', 'SELECT'},
    ['S']        = {'#ffb86c', 'SEL-LN'},
    ['']       = {'#f1fa8c', 'SEL-BLK'},
    ['t']        = {'#6272a4', 'TERMINAL'},
    ['Rv']       = {'#D16D69', 'VIR-REP'},
    ['rm']       = {'#FF5555', '- More -'},
    ['r']        = {'#FF5555', "- Hit-Enter -"},
    ['r?']       = {'#FF5555', "- Confirm -"},
    ['cv']       = {'#8be9fd', "Vim Ex Mode"},
    ['ce']       = {'#8be9fd', "Normal Ex Mode"},
    ['!']        = {'#8be9fd', "Shell Running"},
    ['ic']       = {'#f1fa8c', 'Insert mode completion |compl-generic|'},
    ['no']       = {'#f1fa8c', 'Operator-pending'},
    ['nov']      = {'#f1fa8c', 'Operator-pending (forced charwise |o_v|)'},
    ['noV']      = {'#f1fa8c', 'Operator-pending (forced linewise |o_V|)'},
    ['noCTRL-V'] = {'#f1fa8c', 'Operator-pending (forced blockwise |o_CTRL-V|) CTRL-V is one character'},
    ['niI']      = {'#f1fa8c', 'Normal using |i_CTRL-O| in |Insert-mode|'},
    ['niR']      = {'#f1fa8c', 'Normal using |i_CTRL-O| in |Replace-mode|'},
    ['niV']      = {'#f1fa8c', 'Normal using |i_CTRL-O| in |Virtual-Replace-mode|'},
    ['ix']       = {'#f1fa8c', 'Insert mode |i_CTRL-X| completion'},
    ['Rc']       = {'#f1fa8c', 'Replace mode completion |compl-generic|'},
    ['Rx']       = {'#f1fa8c', 'Replace mode |i_CTRL-X| completion'},
}

-- See: https://www.nerdfonts.com/cheat-sheet
local icons = {
    vim = u 'e62b',
    dos = u 'e70f',
    unix = u 'f17c',
    mac = u 'f179',
}
-- }}}2

-- Rag status function {{{2
local function setLineWidthColours()
    local colbg = colors.statsbg
    local linebg = colors.statsbg

    if (vim.fn.col('.') > lineLengthError)
    then
        colbg = colors.linelongerrorfg
    elseif (vim.fn.col('.') > lineLengthWarning)
    then
        colbg = colors.linelongwarnfg
    end

    if (vim.fn.strwidth(vim.fn.getline('.')) > lineLengthError)
    then
        linebg = colors.linelongerrorfg
    elseif (vim.fn.strwidth(vim.fn.getline('.')) > lineLengthWarning)
    then
        linebg = colors.linelongwarnfg
    end

    highlight('LinePosHighlightStart', colbg, colors.statsbg)
    highlight('LinePosHighlightColNum', colors.statstext, colbg)
    highlight('LinePosHighlhtMid', linebg, colbg)
    highlight('LineLenHighlightLenNum', colors.statstext, linebg)
    highlight('LinePosHighlightEnd', linebg, colors.statsbg)
end
-- }}}2

-- }}}1

-- Left {{{1
gls.left =
    {

        -- Edit mode {{{2
        {
            ViModeSpaceOnFarLeft = {
                provider = function() return " " end,
                highlight = {colors.bg, mode_map[vim.fn.mode()][1]}
            }
        }, {
            ViModeLeft = {
                provider = function()
                    highlight('ViModeHighlight', mode_map[vim.fn.mode()][1], colors.bg)
                    return ''
                end,
                highlight = 'ViModeHighlight'
            }
        }, {
            ViModeIconAndText = {
                provider = function()
                    highlight('GalaxyViMode', colors.bg, mode_map[vim.fn.mode()][1])
                    return icons['vim'] .. " " .. mode_map[vim.fn.mode()][2]
                end,
                highlight = 'GalaxyViMode'
            }
        }, {
            ViModeRight = {
                provider = function()
                    return rightbracket
                end,
                separator = ' ',
                separator_highlight = 'ViModeHighlight',
                highlight = 'ViModeHighlight'
            }
        },
        -- }}}2

        -- Git info {{{2

        -- Git Branch Name {{{3
        {
            GitStart = {
                provider = function() return leftbracket end,
                condition = condition.check_git_workspace,
                highlight = {colors.giticon, colors.bg}
            }
        }, {
            GitIcon = {
                provider = function()
                    return ' '
                end,
                condition = condition.check_git_workspace,
                separator = '',
                separator_highlight = {'NONE', colors.giticon},
                highlight = {colors.gitbg, colors.giticon}
            }
        }, {
            GitMid = {
                provider = function() return rightbracket .. ' ' end,
                condition = condition.check_git_workspace,
                highlight = {colors.giticon, colors.gitbg}
            }
        }, {
            GitBranch = {
                provider = 'GitBranch',
                condition = condition.check_git_workspace,
                separator = ' ',
                separator_highlight = {'NONE', colors.gitbg},
                highlight = {colors.gittext, colors.gitbg}
            }
        },
        -- }}}3

        -- Git Changes {{{3
        {
            DiffAdd = {
                provider = 'DiffAdd',
                condition = condition.check_git_workspace,
                -- icon = '  ',
                icon = '  ',
                highlight = {colors.green, colors.gitbg}
            }
        }, {
            DiffModified = {
                provider = 'DiffModified',
                condition = condition.check_git_workspace,
                -- icon = '  ',
                icon = ' 柳',
                highlight = {colors.blue, colors.gitbg}
            }
        }, {
            DiffRemove = {
                provider = 'DiffRemove',
                condition = condition.check_git_workspace,
                -- icon = '  ',
                icon = '  ',
                highlight = {colors.red, colors.gitbg}
            }
        }, {
            EndGit = {
                provider = function() return rightbracket end,
                condition = condition.check_git_workspace,
                separator = " ",
                separator_highlight = {colors.gitbg, colors.bg},
                highlight = {colors.gitbg, colors.bg}
            }
        },
        -- }}}3

        -- }}}2

        -- Lsp Section {{{2

        -- Lsp Client {{{3
        {
            LspStart = {
                provider = function() return leftbracket end,
                highlight = {colors.lspicon, colors.bg}
            }
        }, {
            LspIcon = {
                provider = function()
                    local name = ""

                    if gl.lspclient ~= nil then
                        name = gl.lspclient()
                    end

                    return ' ' .. name
                end,
                highlight = {colors.lspbg, colors.lspicon}
            }
        }, {
            LspMid = {
                provider = function() return rightbracket .. ' ' end,
                highlight = {colors.lspicon, colors.lspbg}
            }
        }, {
            ShowLspClient = {
                provider = 'GetLspClient',
                highlight = {colors.textbg, colors.lspbg}
            }
        }, {
            LspSpace = {
                provider = function() return ' ' end,
                highlight = {colors.lspicon, colors.lspbg}
            }
        },
        -- }}}

        -- Diagnostics {{{3
        {
            DiagnosticError = {
                provider = 'DiagnosticError',
                icon = '  ',
                separator_highlight = {colors.gitbg, colors.bg},
                highlight = {colors.diagerror, colors.lspbg}
            }
        }, {
            DiagnosticWarn = {
                provider = 'DiagnosticWarn',
                icon = '  ',
                highlight = {colors.diagwarn, colors.lspbg}
            }
        }, {
            DiagnosticHint = {
                provider = 'DiagnosticHint',
                icon = '  ',
                highlight = {colors.diaghint, colors.lspbg}
            }
        }, {
            DiagnosticInfo = {
                provider = 'DiagnosticInfo',
                icon = '  ',
                highlight = {colors.diaginfo, colors.lspbg}
            }
        }, {
            LspSectionEnd = {
                provider = function() return rightbracket .. " " end,
                highlight = {colors.lspbg, colors.bg}
            }
        }

        -- }}}3

        -- }}}2

    }
-- }}}1

-- Right {{{1
gls.right  =
    {
        -- Type {{{2
        {
            TypeStart = {
                provider = function() return leftbracket end,
                highlight = {colors.typeicon, colors.bg}
            }
        }, {
            TypeFileFormatIcon = {
                provider = function()
                    local icon = icons[vim.bo.fileformat] or ''
                    return string.format(' %s', icon)
                end,
                highlight = {colors.typebg, colors.typeicon}
            }
        }, {
            TypeMid = {
                provider = function() return rightbracket .. ' ' end,
                highlight = {colors.typeicon, colors.typebg}
            }
        } ,{
            FileName = {
                provider = 'FileName',
                separator_highlight = {'NONE', colors.typebg},
                highlight = {colors.typetext, colors.typebg}
            }
        },{
            FileIcon = {
                provider = 'FileIcon',
                highlight = {colors.typeicon, colors.typebg}
            }
        }, {
            BufferType = {
                provider = 'FileTypeName',
                highlight = {colors.typetext, colors.typebg}
            }
        }, {
            FileSize = {
                provider = 'FileSize',
                separator = '  ',
                separator_highlight = {colors.typeicon, colors.typebg},
                highlight = {colors.typetext, colors.typebg}
            }
        }, {
            FileEncode = {
                provider = 'FileEncode',
                separator = '',
                separator_highlight = {colors.typeicon, colors.typebg},
                highlight = {colors.typetext, colors.typebg}
            }
        }, {
            TypeSectionEnd = {
                provider = function() return rightbracket end,
                highlight = {colors.typebg, colors.bg}
            }
        }, {
            Space = {
                provider = function() return ' ' end,
                highlight = {colors.typebg, colors.bg}
            }
        },
        -- }}}2

        -- Cursor Position Section {{{2
        {
            StatsSectionStart = {
                provider = function() return leftbracket end,
                highlight = {colors.statsicon, colors.bg}
            }
        }, {
            StatsIcon = {
                provider = function()
                    return '⅑'
                end,
                highlight = {colors.statsbg, colors.statsicon}
            }
        }, {
            StatsMid = {
                provider = function() return rightbracket .. ' ' end,
                highlight = {colors.statsicon, colors.statsbg}
            }
        }, {
            PerCent = {
                provider = 'LinePercent',
                highlight = {colors.statstext, colors.statsbg}
            }
        }, {
            VerticalPosAndSize = {
                provider = function()
                    return string.format("%4i/%4i ", vim.fn.line('.'), vim.fn.line('$'))
                end,
                separator = '⇕ ',
                separator_highlight = {colors.statsicon, colors.statsbg},
                highlight = {colors.statstext, colors.statsbg}
            }
        }, {
            CursorColumnStart = {
                provider = function()
                    return leftbracket
                end,
                separator = '⇔ ',
                separator_highlight = {colors.statsicon, colors.statsbg},
                highlight = 'LinePosHighlightStart'
            }
        }, {
            CursorColumn = {
                provider = function()
                    setLineWidthColours()
                    return " " .. string.format("%3i", vim.fn.col('.')) .. "/"
                end,
                highlight = 'LinePosHighlightColNum'
            }
        }, {
            LineLengthStart = {
                provider = function()
                    return " " .. leftbracket
                end,
                highlight = 'LinePosHighlightMid'
            }
        }, {

            LineLength = {
                provider = function()
                    return ' ' .. string.format("%3i", string.len(vim.fn.getline('.')))
                end,
                highlight = 'LineLenHighlightLenNum'
            }
        }, {
            LineLengthEnd = {
                provider = function()
                    return " " .. rightbracket
                end,
                highlight = 'LinePosHighlightEnd'
            }
        }, {
            TabOrSpace = {
                provider = function()
                    if vim.bo.expandtab
                    then
                        return '⯀'
                    else
                        return '⯈'
                    end
                end,
                condition = condition.hide_in_width,
                highlight = {colors.statsicon, colors.statsbg}
            }
        }, {
            Tabstop = {
                provider = function()
                    if vim.bo.expandtab
                    then
                        return vim.bo.shiftwidth
                    else
                        return vim.bo.shiftwidth
                    end
                end,
                condition = condition.hide_in_width,
                highlight = {colors.statstext, colors.statsbg}
            }
        }, {
            StatsSpcSectionEnd = {
                provider = function() return rightbracket .. " " end,
                highlight = {colors.statsbg, colors.bg}
            }
        }
        -- }}}2
}
-- }}}1

-- Left Short {{{1
gls.short_line_left =
    {
        {
            ShortSectionStart = {
                provider = function() return leftbracket  end,
                highlight = {colors.shortbg, colors.bg}
            }
        },
        {
            ShortSectionSpace = {
                provider = function() return " "  end, highlight = {colors.shorttext, colors.shortbg}
            }
        },
        {
            LeftShortName = {
                provider = 'FileTypeName',
                highlight = {colors.shorttext, colors.shortbg},
            }
        },
        {
            ShortSectionMid = {
                provider = function() return " " end,
                highlight = {colors.shortbg, colors.shortbg}
            }
        },
        {
            LeftShortFileName = {
                provider = 'SFileName',
                condition = condition.buffer_not_empty,
                separator_highlight = {colors.shorttext, colors.shortbg},
                highlight = {colors.shorttext, colors.shortbg},
            }
        },
        {
            ShortSectionEnd = {
                provider = function() return rightbracket end,
                highlight = {colors.shortbg, colors.bg}
            }
        }
    }
-- }}}1

-- Right Short {{{1
gls.short_line_right = {
    BufferIcon = {
        provider = 'BufferIcon',
        separator_highlight = {colors.shorttext, colors.bg},
        highlight = {colors.shortrighttext, colors.bg}
    }
}
-- }}}1
