require("which-key").setup{
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ...
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true -- bindings for prefixed with g
        }
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+" -- symbol prepended to a group
    },
    window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
        padding = {2, 2, 2, 2} -- extra window padding [top, right, bottom, left]
    },
    layout = {
        height = {min = 4, max = 25}, -- min and max height of the columns
        width = {min = 20, max = 50}, -- min and max width of the columns
        spacing = 3 -- spacing between columns
    },
    hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
    show_help = true -- show help message on the command line when the popup is visible
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}


-- Set leader
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '

--Make sure we allow comment commands in visual mode!
vim.api.nvim_set_keymap("v", "<Leader>u", ":echo 'spc-cu is deprecated! use spc-cc instead'<CR>", { silent = false })
vim.api.nvim_set_keymap("n", "<Leader>cu", ":echo 'spc-cu is deprecated! use spc-cc instead'<CR>", { silent = false })
vim.api.nvim_set_keymap("n", "<Leader>cg", ":lua require('neogen').generate()<CR>", { silent = false })
vim.api.nvim_set_keymap("n", "<Leader>w", "<C-w>", { silent = false })

local mappings = {
    p = {
        name = "+Projects",
        p = {":lua require'telescope'.extensions.project.project{}<CR>", "Switch Projects"},
    },
    b = {
        name = "+Buffers",
        b = {"<cmd>Telescope buffers<cr>", "Buffer List"},
        d = {":Bdelete <CR>", "Close Current Buffer"},
        n = {":bNext <CR>", "Next Buffer"},
        p = {":bprevious <CR>", "Previous Buffer"},
    },
    c = {
        name = "+Commenter",
    },
    w = {
        name = "+Window Managment",
    },
    m = {
        name = "+Markdown",
        p = {"<cmd>MarkdownPreview<cr>", "Preview"},
        g = {"<cmd>Glow<cr>", "Glow"},
    },
    n = {
        name = "+Command Shortcuts",
        h = {"<cmd>Telescope command_history<cr>", "Command History"},
        n = {"<cmd>Telescope buffer<cr>", "Open New Buffer"},
    },
    f = {
        name = "+Files",
        t = {"<cmd>NvimTreeToggle<cr>", "File Tree"},
        f = {"<cmd>Telescope find_files<cr>", "Fuzzy Finder"},
        r = {"<cmd>Telescope oldfiles<cr>", "Recent Files"},
        a = {"<cmd>Telescope grep_string<cr>", "Find Words (vimgrep)"},
        o = {"<cmd>Oil<cr>", "Oil"},
    },
    d = {
        name = "+Diagnostics",
        t = {"<cmd>TroubleToggle<cr>", "trouble"},
        w = {"<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "workspace"},
        d = {"<cmd>TroubleToggle lsp_document_diagnostics<cr>", "document"},
        q = {"<cmd>TroubleToggle quickfix<cr>", "quickfix"},
        l = {"<cmd>TroubleToggle loclist<cr>", "loclist"},
        r = {"<cmd>TroubleToggle lsp_references<cr>", "references"},
    },
    D = {
        name = "+Debug",
        b = {"<cmd>DebugToggleBreakpoint<cr>", "Toggle Breakpoint"},
        c = {"<cmd>DebugContinue<cr>", "Continue"},
        i = {"<cmd>DebugStepInto<cr>", "Step Into"},
        o = {"<cmd>DebugStepOver<cr>", "Step Over"},
        r = {"<cmd>DebugToggleRepl<cr>", "Toggle Repl"},
        s = {"<cmd>DebugStart<cr>", "Start"}
    },
    d = {
        name = "+Diagnostic Box",
        d = {"<cmd>TroubleToggle<cr>", "Show diagnostic box"},
        r = {"<cmd>TroubleRefresh<cr>", "Refresh"}
    },
    g = {
        name = "+Git",
        b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
        d = {"<cmd>Git diff %<cr>", "diff current file changes"},
        j = {"<cmd>NextHunk<cr>", "Next Hunk"},
        k = {"<cmd>PrevHunk<cr>", "Prev Hunk"},
        l = {"<cmd>Git log --oneline<cr>", "Git log (single-line)"},
        L = {"<cmd>Git log<cr>", "Git log (verbose)"},
        p = {"<cmd>PreviewHunk<cr>", "Preview Hunk"},
        r = {"<cmd>ResetHunk<cr>", "Reset Hunk"},
        R = {"<cmd>ResetBuffer<cr>", "Reset Buffer"},
        s = {"<cmd>StageHunk<cr>", "Stage Hunk"},
        u = {"<cmd>UndoStageHunk<cr>", "Undo Stage Hunk"},
        g = {"<cmd>Git<cr>", "Status"},
        v = {"<cmd>GV<cr>", "Verbose Log"},
        w = {"<cmd>Git blame<cr>", "Whodunnit?"},
        W = {"<cmd>ToggleBlameLine<cr>", "Whodunnit? (single line)"},
        b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
        c = {"<cmd>Telescope git_commits<cr>", "Checkout commit"},
        C = {"<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)"},
    },
    l = {
        name = "+LSP",
        a = {"<cmd>Lspsaga code_action<CR>", "Code Action Menu"},
        h = {"<cmd>Lspsaga hover_doc<CR>", "Hover Documentation"},
        o = {"<cmd>Lspsaga outline<CR>", "Outline"},
        d = {"<cmd>Lspsaga show_line_diagnostics<CR>", "Line Diagnostics"},
        i = {"<cmd>LspInfo<cr>", "Info"},
        s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
        S = {"<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace Symbols"}
    },
    x = {
        name = "+Latex",
        c = {"<cmd>VimtexCompile<cr>", "Compile"},
        x = {"<cmd>VimtexClean<cr>", "Clean"},
        i = {"<cmd>VimtexInfo<cr>", "Info"},
        r = {"<cmd>VimtexReload<cr>", "Reload"},
        e = {"<cmd>VimtexErrors<cr>", "Errors"},
        l = {"<cmd>VimtexLog<cr>", "Log"}
    },
    t = {
        name = "+Tabs/Buffers",
        h = {"<cmd>lua print(\"now: <SPC> b p\")<cr>", "(Deprecated)"},
        l = {"<cmd>lua print(\"now: <SPC> b n\")<cr>", "(Deprecated)"},
    },
    q = {
        name = "+Leave Neovim",
        q = {":q <CR>", "Quit"},
        t = {":BufferClose <CR>", "Close current buffer"},
        Q = {":qa! <CR>", "Force quit everything!"},
        x = {":x <CR>", "Save and quit current buffer"},
        X = {":xa <CR>", "Save and quit all buffers"},
    },
}

local wk = require("which-key")
wk.register(mappings, opts)
