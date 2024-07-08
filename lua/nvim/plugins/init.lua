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
    'karb94/neoscroll.nvim',
    'sindrets/diffview.nvim',
    'nvim-lua/plenary.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/popup.nvim',
    'rafamadriz/friendly-snippets',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-project.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
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
    'lukas-reineke/indent-blankline.nvim',

    -- Extra opts required
    { 'numToStr/Comment.nvim', lazy = false },
    { 'glepnir/dashboard-nvim', event = 'VimEnter', dependencies = {'nvim-tree/nvim-web-devicons'} },
    { 'williamboman/mason.nvim', run = ':MasonUpdate' },
    { 'hoob3rt/lualine.nvim', dependencies = {'nvim-tree/nvim-web-devicons', opt = true} },
    { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
    { 'folke/trouble.nvim', dependencies = 'nvim-tree/nvim-web-devicons' },
    { 'danymat/neogen', dependencies = 'nvim-treesitter/nvim-treesitter' },
    { 'akinsho/git-conflict.nvim', version = '*', config = true},
    { 'stevearc/oil.nvim', opts = {}, dependencies = { 'nvim-tree/nvim-web-devicons' } },
    { 'L3MON4D3/LuaSnip', version = 'v2.*', build = 'make install_jsregexp' },
    { 'nanozuki/tabby.nvim', dependencies = 'nvim-tree/nvim-web-devicons', },

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
    }
})
