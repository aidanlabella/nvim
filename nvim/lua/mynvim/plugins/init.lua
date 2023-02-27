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
     {'navarasu/onedark.nvim',
        as = 'onedark',
     },

     'dracula/vim',

     'eskilop/NorthernLights.vim',
     'cpea2506/one_monokai.nvim',
     'bluz71/vim-nightfly-guicolors',
     'olimorris/onedarkpro.nvim',
     'folke/tokyonight.nvim',
     'nxvu699134/vn-night.nvim',
     'mg979/vim-visual-multi',
     'preservim/nerdcommenter',
     'tpope/vim-fugitive',
     'prabirshrestha/async.vim',
     'ryanoasis/vim-devicons',
     'majutsushi/tagbar',
     'norcalli/nvim-colorizer.lua',
     'junegunn/gv.vim',
     'rbgrouleff/bclose.vim',
     'francoiscabrol/ranger.vim',
     'vim-syntastic/syntastic',
     'jacoborus/tender.vim',
     'machakann/vim-sandwich',
     'lervag/vimtex',
     'mhinz/vim-startify',

    --Added for NVIM 0.5+:
    -- {'akinsho/bufferline.nvim', tag = "*", dependencies = 'kyazdani42/nvim-web-devicons'}
   --  'akinsho/bufferline.nvim'
   --  {
   --   'kdheepak/tabline.nvim',
   --   dependencies = {
   --       { 'hoob3rt/lualine.nvim', opt=true },
   --       {'kyazdani42/nvim-web-devicons', opt = true}
   --   }
   -- }

   -- Neotree
     {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    },

     'karb94/neoscroll.nvim',
     'sindrets/diffview.nvim',
     'nvim-lua/plenary.nvim',
     'neovim/nvim-lspconfig',
     'williamboman/nvim-lsp-installer',
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
     },

     'folke/which-key.nvim',
     { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu', },
     'famiu/bufdelete.nvim',
     {
      'lewis6991/gitsigns.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim'
      },
      config = function()
        require('gitsigns').setup()
      end
     },
     'folke/lsp-colors.nvim',
     'windwp/nvim-autopairs',
     'tanvirtin/monokai.nvim' ,
     'phanviet/vim-monokai-pro',

     {
      "folke/trouble.nvim",
     },

     {
        "danymat/neogen",
        config = function()
            require('neogen').setup {}
        end,
        dependencies = "nvim-treesitter/nvim-treesitter",
        -- Uncomment next line if you want to follow only stable versions
        -- tag = "*"
    },

     'onsails/lspkind-nvim',
     'ray-x/lsp_signature.nvim',
     'hrsh7th/vim-vsnip',
     'hrsh7th/vim-vsnip-integ',
     'wfxr/minimap.vim',
     'tpope/vim-surround',
     'lukas-reineke/indent-blankline.nvim',
     'chrisbra/csv.vim',
    -- 'numtostr/FTerm.nvim'

    --Too buggy:
    -- {'TimUntersberger/neogit',
        --dependencies = {
            --'nvim-lua/plenary.nvim',
            --'sindrets/diffview.nvim'
        --},
        --config = function()
            --require("neogit").setup(
                    --{
                        --integrations = {
                            --diffview = true
                    --}
                --}
            --)
        --end
    --}
    -- Markdown
    ({ "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" }, }),
     {"ellisonleao/glow.nvim", config = function() require("glow").setup() end},

     'dkarter/bullets.vim',
     'yamatsum/nvim-cursorline',
     'xiyaowong/nvim-transparent',
     'ldelossa/litee.nvim',
     'ldelossa/litee-calltree.nvim',
     --{
        --'akinsho/git-conflict.nvim', tag="*",
        --config = function()
            --require('git-conflict').setup()
        --end
     --},

     'tveskag/nvim-blame-line',

     -- For Nvim 0.8+
     {
        "utilyre/barbecue.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "smiteshp/nvim-navic",
        }
    },

})
