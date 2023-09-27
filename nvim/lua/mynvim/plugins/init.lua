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
    'dracula/vim',
    --{'Mofiqul/dracula.nvim',
        --as = 'dracula',
    --}
    -- Using Packer

    'mg979/vim-visual-multi',
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    },
    { 'TimUntersberger/neogit', dependencies = 'nvim-lua/plenary.nvim' },
    'tpope/vim-fugitive',
    'prabirshrestha/async.vim',
    'ryanoasis/vim-devicons',
    'nvim-tree/nvim-web-devicons',
    'majutsushi/tagbar',
    'norcalli/nvim-colorizer.lua',
    'junegunn/gv.vim',
    'rbgrouleff/bclose.vim',
    'francoiscabrol/ranger.vim',
    'vim-syntastic/syntastic',
    'machakann/vim-sandwich',
    'lervag/vimtex',
    {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function()
          require('dashboard').setup {
            -- config
          }
        end,
        dependencies = {'nvim-tree/nvim-web-devicons'}
    },

    --Added for NVIM 0.5+:
    --{'akinsho/bufferline.nvim', tag = "*", dependencies = 'kyazdani42/nvim-web-devicons'}
   -- 'akinsho/bufferline.nvim'
   -- {
   --   'kdheepak/tabline.nvim',
   --   dependencies = {
   --       { 'hoob3rt/lualine.nvim', opt=true },
   --       {'kyazdani42/nvim-web-devicons', opt = true}
   --   }
   -- }

    'karb94/neoscroll.nvim',
    'kyazdani42/nvim-tree.lua',
    'sindrets/diffview.nvim',
    'nvim-lua/plenary.nvim',

    -- LSP
    {
        "williamboman/mason.nvim",
        run = ":MasonUpdate" -- :MasonUpdate updates registry contents
    },

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

    {
        'hoob3rt/lualine.nvim',
        dependencies = {'nvim-tree/nvim-web-devicons', opt = true}
    },

    'folke/which-key.nvim',
    { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu', },
    'famiu/bufdelete.nvim',
    {
      'lewis6991/gitsigns.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim'
      },
    },
    'folke/lsp-colors.nvim',
    'windwp/nvim-autopairs',
    {
        'tanvirtin/monokai.nvim' ,
    },
    {
        'phanviet/vim-monokai-pro',
    },

    {
      "folke/trouble.nvim",
      dependencies = "nvim-tree/nvim-web-devicons",
    },

    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        -- Uncomment next line if you want to follow only stable versions
        -- tag = "*"
    },

    'onsails/lspkind-nvim',
    'ray-x/lsp_signature.nvim',
    'hrsh7th/vim-vsnip',
    'hrsh7th/vim-vsnip-integ',
    --'wfxr/minimap.vim'
    --
    -- Too ugly
    --'p00f/nvim-ts-rainbow'
    'tpope/vim-surround',
    'lukas-reineke/indent-blankline.nvim',
    'chrisbra/csv.vim',

    -- Markdown
    { "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        init = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" }, },

    {"ellisonleao/glow.nvim"},
    'dkarter/bullets.vim',
    'yamatsum/nvim-cursorline',
    'ldelossa/litee.nvim',
    'ldelossa/litee-calltree.nvim',
    {'akinsho/git-conflict.nvim', version = "*", config = true},
    {'j-hui/fidget.nvim', tag = 'legacy'},

    'tveskag/nvim-blame-line',

    -- For Nvim 0.8+
    'smiteshp/nvim-navic',
    {'nvim-neo-tree/neo-tree.nvim',
        branch = "v2.x",
        dependencies = {
         "nvim-lua/plenary.nvim",
         "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
         "MunifTanjim/nui.nvim"}
    },

    {
        "utilyre/barbecue.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "smiteshp/nvim-navic",
        }
    },
})
