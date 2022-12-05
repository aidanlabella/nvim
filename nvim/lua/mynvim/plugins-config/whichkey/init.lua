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
  if view.is_visible() then
    vim.api.nvim_exec([[NvimTreeClose]], false)
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
    },
    c = {
        name = "+Commenter",
    },
    w = {
        name = "+Window Managment",
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
        d = {"<cmd>Git diff %<cr>", "diff current file changes"},
        j = {"<cmd>NextHunk<cr>", "Next Hunk"},
        k = {"<cmd>PrevHunk<cr>", "Prev Hunk"},
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
        a = {":CodeActionMenu<CR>", "Code Action Menu"},
        d = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
        D = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
        f = {"<cmd>LspFormatting<cr>", "Format"},
        i = {"<cmd>LspInfo<cr>", "Info"},
        q = {"<cmd>Telescope quickfix<cr>", "Quickfix"},
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
    t = {
        name = "+Tabs/Buffers",
        b = {"<cmd>Telescope buffers<cr>", "Buffer List"},
        h = {"<cmd>BufferLineCyclePrev<cr>", "Tab/buffer left"},
        l = {"<cmd>BufferLineCycleNext<cr>", "Tab/buffer right"},
        k = {":Bdelete <CR>", "Close current buffer"},
        ["1"] = {"<cmd>BufferLineGoToBuffer 1<cr>", "Goto tab 1"},
        ["2"] = {"<cmd>BufferLineGoToBuffer 2<cr>", "Goto tab 2"},
        ["3"] = {"<cmd>BufferLineGoToBuffer 3<cr>", "Goto tab 3"},
        ["4"] = {"<cmd>BufferLineGoToBuffer 4<cr>", "Goto tab 4"},
        ["5"] = {"<cmd>BufferLineGoToBuffer 5<cr>", "Goto tab 5"},
        ["6"] = {"<cmd>BufferLineGoToBuffer 6<cr>", "Goto tab 6"},
        ["7"] = {"<cmd>BufferLineGoToBuffer 7<cr>", "Goto tab 7"},
        ["8"] = {"<cmd>BufferLineGoToBuffer 8<cr>", "Goto tab 8"},
        ["9"] = {"<cmd>BufferLineGoToBuffer 9<cr>", "Goto tab 9"},
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
