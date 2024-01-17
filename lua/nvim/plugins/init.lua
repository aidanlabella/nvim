local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Colorschemes
    'navarasu/onedark.nvim',
    -- 'dracula/vim',
    'Mofiqul/dracula.nvim',
    
    'mg979/vim-visual-multi',
    { 'numToStr/Comment.nvim', lazy = false },
    { 'TimUntersberger/neogit', dependencies = 'nvim-lua/plenary.nvim' },
    'tpope/vim-fugitive',
    'prabirshrestha/async.vim',
    'ryanoasis/vim-devicons',
    'nvim-tree/nvim-web-devicons',
    'norcalli/nvim-colorizer.lua',
    'junegunn/gv.vim',
    'machakann/vim-sandwich',
    'lervag/vimtex',
    { 'glepnir/dashboard-nvim', event = 'VimEnter', dependencies = {'nvim-tree/nvim-web-devicons'} },
    'karb94/neoscroll.nvim',
    'sindrets/diffview.nvim',
    'nvim-lua/plenary.nvim',

    -- LSP
    { "williamboman/mason.nvim", run = ":MasonUpdate" },
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/popup.nvim',

    --Telescope
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-project.nvim',
    'kosayoda/nvim-lightbulb',

    --Completion
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',

    { 'hoob3rt/lualine.nvim', dependencies = {'nvim-tree/nvim-web-devicons', opt = true} },
    'folke/which-key.nvim',
    'nvimdev/lspsaga.nvim',
    'famiu/bufdelete.nvim',
    { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
    'folke/lsp-colors.nvim',
    'windwp/nvim-autopairs',

    { "folke/trouble.nvim", dependencies = "nvim-tree/nvim-web-devicons" },

    { "danymat/neogen", dependencies = "nvim-treesitter/nvim-treesitter" },

    'onsails/lspkind-nvim',
    'ray-x/lsp_signature.nvim',
    --
    -- Too ugly
    'tpope/vim-surround',
    'lukas-reineke/indent-blankline.nvim',
    'chrisbra/csv.vim',

    -- Markdown
    { "iamcco/markdown-preview.nvim", build = "cd app && npm install", init = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" } },

    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("nvim-tree").setup {}
      end,
    },

    {"ellisonleao/glow.nvim"},
    'yamatsum/nvim-cursorline',
    'ldelossa/litee.nvim',
    'ldelossa/litee-calltree.nvim',
    {'akinsho/git-conflict.nvim', version = "*", config = true},
    {'j-hui/fidget.nvim', tag = 'legacy'},

    'tveskag/nvim-blame-line',
    'xiyaowong/transparent.nvim',

    -- For Nvim 0.8+
    'smiteshp/nvim-navic',
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "utilyre/barbecue.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "smiteshp/nvim-navic",
        }
    },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },
    'rafamadriz/friendly-snippets',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
})
