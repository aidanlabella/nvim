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

-- OLD SPEC:
-- local mappings = {
--     E = {":Oil<CR>", "Files"},
--     V = {":vnew<CR>", "Open VSplit"},
--     F = {":tabnew<CR>:Oil<CR>", "Open Tab (files)"},
--     p = {
--         name = "+Projects",
--         p = {":lua require'telescope'.extensions.project.project{}<CR>", "Switch Projects"},
--     },
--     b = {
--         name = "+Buffers",
--         b = {"<cmd>Telescope buffers<cr>", "Buffer List"},
--         d = {":Bdelete <CR>", "Close Current Buffer"},
--         n = {":bNext <CR>", "Next Buffer"},
--         p = {":bprevious <CR>", "Previous Buffer"},
--     },
--     c = {
--         name = "+Commenter",
--     },
--     w = {
--         name = "+Window Managment",
--     },
--     m = {
--         name = "+Markdown",
--         p = {"<cmd>MarkdownPreview<cr>", "Preview"},
--         g = {"<cmd>Glow<cr>", "Glow"},
--     },
--     n = {
--         name = "+Command Shortcuts",
--         h = {"<cmd>Telescope command_history<cr>", "Command History"},
--         n = {"<cmd>Telescope buffer<cr>", "Open New Buffer"},
--     },
--     f = {
--         name = "+Files",
--         t = {":vnew<CR>:Oil<CR>", "File Split (Oil)"},
--         f = {"<cmd>Telescope find_files<cr>", "Fuzzy Finder"},
--         r = {"<cmd>Telescope oldfiles<cr>", "Recent Files"},
--         a = {"<cmd>Telescope grep_string<cr>", "Find Words (vimgrep)"},
--         o = {"<cmd>Oil<cr>", "Oil"},
--     },
--     d = {
--         name = "+Diagnostics",
--         t = {"<cmd>TroubleToggle<cr>", "trouble"},
--         w = {"<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "workspace"},
--         d = {"<cmd>TroubleToggle lsp_document_diagnostics<cr>", "document"},
--         q = {"<cmd>TroubleToggle quickfix<cr>", "quickfix"},
--         l = {"<cmd>TroubleToggle loclist<cr>", "loclist"},
--         r = {"<cmd>TroubleToggle lsp_references<cr>", "references"},
--     },
--     D = {
--         name = "+Debug",
--         b = {"<cmd>DebugToggleBreakpoint<cr>", "Toggle Breakpoint"},
--         c = {"<cmd>DebugContinue<cr>", "Continue"},
--         i = {"<cmd>DebugStepInto<cr>", "Step Into"},
--         o = {"<cmd>DebugStepOver<cr>", "Step Over"},
--         r = {"<cmd>DebugToggleRepl<cr>", "Toggle Repl"},
--         s = {"<cmd>DebugStart<cr>", "Start"}
--     },
--     d = {
--         name = "+Diagnostic Box",
--         d = {"<cmd>TroubleToggle<cr>", "Show diagnostic box"},
--         r = {"<cmd>TroubleRefresh<cr>", "Refresh"}
--     },
--     g = {
--         name = "+Git",
--         a = {"<cmd>Git add %<cr>", "Stage current file"},
--         c = {"<cmd>Git commit<cr>", "Commit"},
--         p = {"<cmd>Git push<cr>", "Push"},
--         P = {"<cmd>Git pull<cr>", "Pull"},
--         b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
--         d = {"<cmd>Git diff %<cr>", "diff current file changes"},
--         j = {"<cmd>NextHunk<cr>", "Next Hunk"},
--         k = {"<cmd>PrevHunk<cr>", "Prev Hunk"},
--         l = {"<cmd>Git log --oneline<cr>", "Git log (single-line)"},
--         L = {"<cmd>Git log<cr>", "Git log (verbose)"},
--         r = {"<cmd>ResetHunk<cr>", "Reset Hunk"},
--         R = {"<cmd>ResetBuffer<cr>", "Reset Buffer"},
--         s = {"<cmd>StageHunk<cr>", "Stage Hunk"},
--         u = {"<cmd>UndoStageHunk<cr>", "Undo Stage Hunk"},
--         g = {"<cmd>Git<cr>", "Status"},
--         v = {"<cmd>GV<cr>", "Verbose Log"},
--         w = {"<cmd>Git blame<cr>", "Whodunnit?"},
--         W = {"<cmd>ToggleBlameLine<cr>", "Whodunnit? (single line)"},
--         b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
--         C = {"<cmd>Telescope git_commits<cr>", "Checkout commit"},
--     },
--     l = {
--         name = "+LSP",
--         a = {"<cmd>Lspsaga code_action<CR>", "Code Action Menu"},
--         h = {"<cmd>Lspsaga hover_doc<CR>", "Hover Documentation"},
--         o = {"<cmd>Lspsaga outline<CR>", "Outline"},
--         d = {"<cmd>Lspsaga show_line_diagnostics<CR>", "Line Diagnostics"},
--         i = {"<cmd>LspInfo<cr>", "Info"},
--         s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
--         S = {"<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace Symbols"}
--     },
--     x = {
--         name = "+Latex",
--         c = {"<cmd>VimtexCompile<cr>", "Compile"},
--         x = {"<cmd>VimtexClean<cr>", "Clean"},
--         i = {"<cmd>VimtexInfo<cr>", "Info"},
--         r = {"<cmd>VimtexReload<cr>", "Reload"},
--         e = {"<cmd>VimtexErrors<cr>", "Errors"},
--         l = {"<cmd>VimtexLog<cr>", "Log"}
--     },
--     t = {
--         name = "+Tabs/Buffers",
--         h = {"<cmd>tabprevious<cr>", "Prev. Tab"},
--         l = {"<cmd>tabnext<cr>", "Next Tab"},
--         n = {"<cmd>tabnew<cr>", "New Tab"},
--         k = {"<cmd>q<cr>", "Kill Tab"},
--         K = {"<cmd>q!<cr>", "Kill Tab (forcibly)"},
--     },
--     q = {
--         name = "+Leave Neovim",
--         q = {":q <CR>", "Quit"},
--         t = {":BufferClose <CR>", "Close current buffer"},
--         Q = {":qa! <CR>", "Force quit everything!"},
--         x = {":x <CR>", "Save and quit current buffer"},
--         X = {":xa <CR>", "Save and quit all buffers"},
--     },
-- }

local mappings = 
{
    { "<leader>D", group = "Debug", nowait = false, remap = false },
    { "<leader>Db", "<cmd>DebugToggleBreakpoint<cr>", desc = "Toggle Breakpoint", nowait = false, remap = false },
    { "<leader>Dc", "<cmd>DebugContinue<cr>", desc = "Continue", nowait = false, remap = false },
    { "<leader>Di", "<cmd>DebugStepInto<cr>", desc = "Step Into", nowait = false, remap = false },
    { "<leader>Do", "<cmd>DebugStepOver<cr>", desc = "Step Over", nowait = false, remap = false },
    { "<leader>Dr", "<cmd>DebugToggleRepl<cr>", desc = "Toggle Repl", nowait = false, remap = false },
    { "<leader>Ds", "<cmd>DebugStart<cr>", desc = "Start", nowait = false, remap = false },
    { "<leader>E", ":Oil<CR>", desc = "Files", nowait = false, remap = false },
    { "<leader>F", ":tabnew<CR>:Oil<CR>", desc = "Open Tab (files)", nowait = false, remap = false },
    { "<leader>V", ":vnew<CR>", desc = "Open VSplit", nowait = false, remap = false },
    { "<leader>b", group = "Buffers", nowait = false, remap = false },
    { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Buffer List", nowait = false, remap = false },
    { "<leader>bd", ":Bdelete <CR>", desc = "Close Current Buffer", nowait = false, remap = false },
    { "<leader>bn", ":bNext <CR>", desc = "Next Buffer", nowait = false, remap = false },
    { "<leader>bp", ":bprevious <CR>", desc = "Previous Buffer", nowait = false, remap = false },
    { "<leader>c", group = "Commenter", nowait = false, remap = false },
    { "<leader>d", group = "Diagnostic Box", nowait = false, remap = false },
    { "<leader>dd", "<cmd>TroubleToggle<cr>", desc = "Show diagnostic box", nowait = false, remap = false },
    { "<leader>dr", "<cmd>TroubleRefresh<cr>", desc = "Refresh", nowait = false, remap = false },
    { "<leader>f", group = "Files", nowait = false, remap = false },
    { "<leader>fa", "<cmd>Telescope grep_string<cr>", desc = "Find Words (vimgrep)", nowait = false, remap = false },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Fuzzy Finder", nowait = false, remap = false },
    { "<leader>fo", "<cmd>Oil<cr>", desc = "Oil", nowait = false, remap = false },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files", nowait = false, remap = false },
    { "<leader>ft", ":vnew<CR>:Oil<CR>", desc = "File Split (Oil)", nowait = false, remap = false },
    { "<leader>g", group = "Git", nowait = false, remap = false },
    { "<leader>gC", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit", nowait = false, remap = false },
    { "<leader>gL", "<cmd>Git log<cr>", desc = "Git log (verbose)", nowait = false, remap = false },
    { "<leader>gP", "<cmd>Git pull<cr>", desc = "Pull", nowait = false, remap = false },
    { "<leader>gR", "<cmd>ResetBuffer<cr>", desc = "Reset Buffer", nowait = false, remap = false },
    { "<leader>gW", "<cmd>ToggleBlameLine<cr>", desc = "Whodunnit? (single line)", nowait = false, remap = false },
    { "<leader>ga", "<cmd>Git add %<cr>", desc = "Stage current file", nowait = false, remap = false },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = false, remap = false },
    { "<leader>gc", "<cmd>Git commit<cr>", desc = "Commit", nowait = false, remap = false },
    { "<leader>gd", "<cmd>Git diff %<cr>", desc = "diff current file changes", nowait = false, remap = false },
    { "<leader>gg", "<cmd>Git<cr>", desc = "Status", nowait = false, remap = false },
    { "<leader>gj", "<cmd>NextHunk<cr>", desc = "Next Hunk", nowait = false, remap = false },
    { "<leader>gk", "<cmd>PrevHunk<cr>", desc = "Prev Hunk", nowait = false, remap = false },
    { "<leader>gl", "<cmd>Git log --oneline<cr>", desc = "Git log (single-line)", nowait = false, remap = false },
    { "<leader>gp", "<cmd>Git push<cr>", desc = "Push", nowait = false, remap = false },
    { "<leader>gr", "<cmd>ResetHunk<cr>", desc = "Reset Hunk", nowait = false, remap = false },
    { "<leader>gs", "<cmd>StageHunk<cr>", desc = "Stage Hunk", nowait = false, remap = false },
    { "<leader>gu", "<cmd>UndoStageHunk<cr>", desc = "Undo Stage Hunk", nowait = false, remap = false },
    { "<leader>gv", "<cmd>GV<cr>", desc = "Verbose Log", nowait = false, remap = false },
    { "<leader>gw", "<cmd>Git blame<cr>", desc = "Whodunnit?", nowait = false, remap = false },
    { "<leader>l", group = "LSP", nowait = false, remap = false },
    { "<leader>lS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols", nowait = false, remap = false },
    { "<leader>la", "<cmd>Lspsaga code_action<CR>", desc = "Code Action Menu", nowait = false, remap = false },
    { "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Line Diagnostics", nowait = false, remap = false },
    { "<leader>lh", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover Documentation", nowait = false, remap = false },
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info", nowait = false, remap = false },
    { "<leader>lo", "<cmd>Lspsaga outline<CR>", desc = "Outline", nowait = false, remap = false },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols", nowait = false, remap = false },
    { "<leader>m", group = "Markdown", nowait = false, remap = false },
    { "<leader>mg", "<cmd>Glow<cr>", desc = "Glow", nowait = false, remap = false },
    { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Preview", nowait = false, remap = false },
    { "<leader>n", group = "Command Shortcuts", nowait = false, remap = false },
    { "<leader>nh", "<cmd>Telescope command_history<cr>", desc = "Command History", nowait = false, remap = false },
    { "<leader>nn", "<cmd>Telescope buffer<cr>", desc = "Open New Buffer", nowait = false, remap = false },
    { "<leader>p", group = "Projects", nowait = false, remap = false },
    { "<leader>pp", ":lua require'telescope'.extensions.project.project{}<CR>", desc = "Switch Projects", nowait = false, remap = false },
    { "<leader>q", group = "Leave Neovim", nowait = false, remap = false },
    { "<leader>qQ", ":qa! <CR>", desc = "Force quit everything!", nowait = false, remap = false },
    { "<leader>qX", ":xa <CR>", desc = "Save and quit all buffers", nowait = false, remap = false },
    { "<leader>qq", ":q <CR>", desc = "Quit", nowait = false, remap = false },
    { "<leader>qt", ":BufferClose <CR>", desc = "Close current buffer", nowait = false, remap = false },
    { "<leader>qx", ":x <CR>", desc = "Save and quit current buffer", nowait = false, remap = false },
    { "<leader>t", group = "Tabs/Buffers", nowait = false, remap = false },
    { "<leader>tK", "<cmd>q!<cr>", desc = "Kill Tab (forcibly)", nowait = false, remap = false },
    { "<leader>th", "<cmd>tabprevious<cr>", desc = "Prev. Tab", nowait = false, remap = false },
    { "<leader>tk", "<cmd>q<cr>", desc = "Kill Tab", nowait = false, remap = false },
    { "<leader>tl", "<cmd>tabnext<cr>", desc = "Next Tab", nowait = false, remap = false },
    { "<leader>tn", "<cmd>tabnew<cr>", desc = "New Tab", nowait = false, remap = false },
    { "<leader>w", group = "Window Managment", nowait = false, remap = false },
    { "<leader>x", group = "Latex", nowait = false, remap = false },
    { "<leader>xc", "<cmd>VimtexCompile<cr>", desc = "Compile", nowait = false, remap = false },
    { "<leader>xe", "<cmd>VimtexErrors<cr>", desc = "Errors", nowait = false, remap = false },
    { "<leader>xi", "<cmd>VimtexInfo<cr>", desc = "Info", nowait = false, remap = false },
    { "<leader>xl", "<cmd>VimtexLog<cr>", desc = "Log", nowait = false, remap = false },
    { "<leader>xr", "<cmd>VimtexReload<cr>", desc = "Reload", nowait = false, remap = false },
    { "<leader>xx", "<cmd>VimtexClean<cr>", desc = "Clean", nowait = false, remap = false },
}

local wk = require("which-key")
wk.add(mappings)
