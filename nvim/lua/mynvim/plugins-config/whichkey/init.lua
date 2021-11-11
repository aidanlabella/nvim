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

local view = require'nvim-tree.view'

tree_ctl = {}
tree_ctl.toggle_tree = function()
  if view.win_open() then
    require'nvim-tree'.close()
    require'bufferline.state'.set_offset(0)
  else
    require'bufferline.state'.set_offset(35, 'File Explorer')
    require'nvim-tree'.find_file(true)
  end
end


-- Set leader
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '

--Make sure we allow comment commands in visual mode!
vim.api.nvim_set_keymap("v", "<Leader>cc", "<cmd>lua require('Comment').toggle()<cr>", { silent = false })
vim.api.nvim_set_keymap("v", "<Leader>cu", "<cmd>lua require('Comment').uncomment()<cr>", { silent = false })

local mappings = {
    p = {
        name = "+Projects",
        p = {":lua require'telescope'.extensions.project.project{}<CR>", "Switch Projects"},
    },
    c = {
        name = "+Commenter",
        c = {"<cmd>lua require('Comment').toggle()<cr>", "Toggle comments on line/region"},
        u = {"<cmd>lua require('Comment').uncomment()<cr>", "Uncomment line/region"},
    },
    n = {
        name = "+Command Shortcuts",
        h = {"<cmd>Telescope command_history<cr>", "Command History"},
        n = {"<cmd>Telescope buffer<cr>", "Open New Buffer"},
    },
    f = {
        name = "+Files",
        t = {"<cmd>lua tree_ctl.toggle_tree()<cr>", "File Tree"},
        f = {"<cmd>Telescope find_files<cr>", "Fuzzy Finder"},
        r = {"<cmd>Telescope file_browser<cr>", "File Browser"},
        a = {"<cmd>Telescope grep_string<cr>", "Find Words (vimgrep)"},
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
        j = {"<cmd>NextHunk<cr>", "Next Hunk"},
        k = {"<cmd>PrevHunk<cr>", "Prev Hunk"},
        p = {"<cmd>PreviewHunk<cr>", "Preview Hunk"},
        r = {"<cmd>ResetHunk<cr>", "Reset Hunk"},
        R = {"<cmd>ResetBuffer<cr>", "Reset Buffer"},
        s = {"<cmd>StageHunk<cr>", "Stage Hunk"},
        u = {"<cmd>UndoStageHunk<cr>", "Undo Stage Hunk"},
        g = {"<cmd>Git<cr>", "Status"},
        b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
        c = {"<cmd>Telescope git_commits<cr>", "Checkout commit"},
        C = {"<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)"},
    },
    l = {
        name = "+LSP",
        a = {":Lspsaga code_action<CR>", "Code Action"},
        A = {"<cmd>Lspsaga range_code_action<cr>", "Selected Action"},
        d = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
        D = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
        f = {"<cmd>LspFormatting<cr>", "Format"},
        i = {"<cmd>LspInfo<cr>", "Info"},
        l = {"<cmd>Lspsaga lsp_finder<cr>", "LSP Finder"},
        L = {"<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics"},
        p = {"<cmd>Lspsaga preview_definition<cr>", "Preview Definition"},
        q = {"<cmd>Telescope quickfix<cr>", "Quickfix"},
        r = {"<cmd>Lspsaga rename<cr>", "Rename"},
        t = {"<cmd>LspTypeDefinition<cr>", "Type Definition"},
        x = {"<cmd>cclose<cr>", "Close Quickfix"},
        s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
        S = {"<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace Symbols"}
    },
    x = {
        name = "+Latex",
        c = {"<cmd>VimtexCompile<cr>", "Compile"},
        i = {"<cmd>VimtexInfo<cr>", "Info"},
        r = {"<cmd>VimtexReload<cr>", "Reload"},
        r = {"<cmd>VimtexErrors<cr>", "Errors"},
        r = {"<cmd>VimtexLog<cr>", "Log"}
    },
    w = {
        name = "+Windows",
        c = {"<C-W>q", "Close selected window"},
        h = {"<C-W>h", "Window left"},
        j = {"<C-W>j", "Window below"},
        k = {"<C-W>k", "Window above"},
        l = {"<C-W>l", "Window right"},
    },
    t = {
        name = "+Tabs/Buffers",
        h = {"<cmd>BufferPrevious<cr>", "Tab/buffer left"},
        l = {"<cmd>BufferNext<cr>", "Tab/buffer right"},
        k = {":BufferClose <CR>", "Close current buffer"},
        ["1"] = {"<cmd>1bnext<cr>", "Goto tab/buffer 1"},
        ["2"] = {"<cmd>2bnext<cr>", "Goto tab/buffer 2"},
        ["3"] = {"<cmd>3bnext<cr>", "Goto tab/buffer 3"},
        ["4"] = {"<cmd>4bnext<cr>", "Goto tab/buffer 4"},
        ["5"] = {"<cmd>5bnext<cr>", "Goto tab/buffer 5"},
        ["6"] = {"<cmd>6bnext<cr>", "Goto tab/buffer 6"},
        ["7"] = {"<cmd>7bnext<cr>", "Goto tab/buffer 7"},
        ["8"] = {"<cmd>8bnext<cr>", "Goto tab/buffer 8"},
        ["9"] = {"<cmd>9bnext<cr>", "Goto tab/buffer 9"},
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
