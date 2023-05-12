return require('packer').startup(function()
    -- This package manager (bootstrap)
    use 'wbthomason/packer.nvim'

    -- Colorschemes
    use 'navarasu/onedark.nvim'
    use 'dracula/vim'
    --use {'Mofiqul/dracula.nvim',
        --as = 'dracula',
    --}
    -- Using Packer

    use 'mg979/vim-visual-multi'
    use 'preservim/nerdcommenter'
    use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
    use 'tpope/vim-fugitive'
    use 'prabirshrestha/async.vim'
    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'
    use 'majutsushi/tagbar'
    use 'norcalli/nvim-colorizer.lua'
    use 'junegunn/gv.vim'
    use 'rbgrouleff/bclose.vim'
    use 'francoiscabrol/ranger.vim'
    use 'vim-syntastic/syntastic'
    use 'machakann/vim-sandwich'
    use 'lervag/vimtex'
    use {
        'goolord/alpha-nvim',
        requires = { 'nvim-tree/nvim-web-devicons' }
    }

    --Added for NVIM 0.5+:
    --use {'akinsho/bufferline.nvim', tag = "*", requires = 'kyazdani42/nvim-web-devicons'}
   -- use 'akinsho/bufferline.nvim'
   -- use {
   --   'kdheepak/tabline.nvim',
   --   requires = {
   --       { 'hoob3rt/lualine.nvim', opt=true },
   --       {'kyazdani42/nvim-web-devicons', opt = true}
   --   }
   -- }

    use 'karb94/neoscroll.nvim'
    use 'kyazdani42/nvim-tree.lua'
    use 'sindrets/diffview.nvim'
    use 'nvim-lua/plenary.nvim'

    -- LSP
    use {
        "williamboman/mason.nvim",
        run = ":MasonUpdate" -- :MasonUpdate updates registry contents
    }
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'

    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-lua/popup.nvim'

    --Telescope
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-project.nvim'
    use 'kosayoda/nvim-lightbulb'

    --Completion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    use 'folke/which-key.nvim'
    use { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu', }
    use 'famiu/bufdelete.nvim'
    use {
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
      config = function()
        require('gitsigns').setup()
      end
    }
    use 'folke/lsp-colors.nvim'
    use 'windwp/nvim-autopairs'
    use {
        'tanvirtin/monokai.nvim' ,
    }
    use {
        'phanviet/vim-monokai-pro',
    }

    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
    }

    use {
        "danymat/neogen",
        config = function()
            require('neogen').setup {}
        end,
        requires = "nvim-treesitter/nvim-treesitter",
        -- Uncomment next line if you want to follow only stable versions
        -- tag = "*"
    }

    use 'onsails/lspkind-nvim'
    use 'ray-x/lsp_signature.nvim'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    --use 'wfxr/minimap.vim'
    --
    -- Too ugly
    --use 'p00f/nvim-ts-rainbow'
    use 'tpope/vim-surround'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'chrisbra/csv.vim'
    --use 'numtostr/FTerm.nvim'

    --Too buggy:
    --use {'TimUntersberger/neogit',
        --requires = {
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
    use({ "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" }, })
    use {"ellisonleao/glow.nvim", config = function() require("glow").setup() end}

    use 'dkarter/bullets.vim'
    use 'yamatsum/nvim-cursorline'
    use 'ldelossa/litee.nvim'
    use 'ldelossa/litee-calltree.nvim'
    use {
        'akinsho/git-conflict.nvim', tag = "*",
        config = function()
            require('git-conflict').setup()
        end
    }

    use 'tveskag/nvim-blame-line'

    -- For Nvim 0.8+
    use 'SmiteshP/nvim-navic'
    use {'nvim-neo-tree/neo-tree.nvim',
        branch = "v2.x",
        requires = {
         "nvim-lua/plenary.nvim",
         "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
         "MunifTanjim/nui.nvim"}
    }

    use {
        "utilyre/barbecue.nvim",
        requires = {
            "neovim/nvim-lspconfig",
            "smiteshp/nvim-navic",
        }
    }

end)
