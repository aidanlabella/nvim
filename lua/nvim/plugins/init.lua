local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- Plug-n-play or config elsewhere
    'navarasu/onedark.nvim',
    'tpope/vim-fugitive',
    'ryanoasis/vim-devicons',
    'nvim-tree/nvim-web-devicons',
    'norcalli/nvim-colorizer.lua',
    'junegunn/gv.vim',
    'lervag/vimtex',
    'Mofiqul/dracula.nvim',
    'sindrets/diffview.nvim',
    'nvim-lua/plenary.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'nvim-lua/popup.nvim',
    'folke/which-key.nvim',
    'nvimdev/lspsaga.nvim',
    'famiu/bufdelete.nvim',
    'folke/lsp-colors.nvim',
    'windwp/nvim-autopairs',
    'yamatsum/nvim-cursorline',
    'tveskag/nvim-blame-line',
    'xiyaowong/transparent.nvim',
    'ellisonleao/glow.nvim',
    'onsails/lspkind-nvim',
    'ray-x/lsp_signature.nvim',
    'karb94/neoscroll.nvim',

    -- Extra opts required
    { 'saghen/blink.cmp', dependencies = { 'rafamadriz/friendly-snippets'} },
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    { 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = {'nvim-lua/plenary.nvim'}},
    { 'numToStr/Comment.nvim', lazy = false },
    { 'glepnir/dashboard-nvim', event = 'VimEnter', dependencies = {'nvim-tree/nvim-web-devicons'} },
    { 'williamboman/mason.nvim', run = ':MasonUpdate' },
    { 'hoob3rt/lualine.nvim', dependencies = {'nvim-tree/nvim-web-devicons', opt = true} },
    { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
    { 'folke/trouble.nvim', opts = {}, cmd = "Trouble", },
    { 'danymat/neogen', dependencies = 'nvim-treesitter/nvim-treesitter' },
    { 'akinsho/git-conflict.nvim', version = '*', config = true},
    { 'stevearc/oil.nvim', opts = {}, dependencies = { 'nvim-tree/nvim-web-devicons' } },
    { 'L3MON4D3/LuaSnip', version = 'v2.*', build = 'make install_jsregexp' },
    { 'nanozuki/tabby.nvim', dependencies = 'nvim-tree/nvim-web-devicons', },
    { 'echasnovski/mini.icons', init = function() require('mini.icons').setup() end, },
    { 'Bekaboo/dropbar.nvim', dependencies = { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } },

    -- Inline configuration
    { 'kylechui/nvim-surround',
        version = '*', -- Use for stability; omit to use `main` branch for the latest features
        event = 'VeryLazy',
        config = function()
            require('nvim-surround').setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    { 'iamcco/markdown-preview.nvim',
        build = 'cd app && npm install',
        init = function()
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
        ft = { 'markdown' }
    },
    { 'nvim-tree/nvim-tree.lua',
        version = '*',
        lazy = false,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
        require('nvim-tree').setup {}
        end,
    },
    { 'cameron-wags/rainbow_csv.nvim',
        config = true,
        ft = {
            'csv',
            'tsv',
            'csv_semicolon',
            'csv_whitespace',
            'csv_pipe',
            'rfc_csv',
            'rfc_semicolon'
        },
        cmd = {
            'RainbowDelim',
            'RainbowDelimSimple',
            'RainbowDelimQuoted',
            'RainbowMultiDelim'
        }
    },

    -- Snacks plugin
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            animate = { enabled = true },
            bigfile = { enabled = true },
            indent = { enabled = true, only_scope = true, only_current = true },
            input = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scratch = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
    }
})
