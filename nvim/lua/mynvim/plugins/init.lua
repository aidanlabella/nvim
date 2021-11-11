return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use {
    'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }


    -- Change colorscheme here and adjust sources/configs as such for other highlights
    use {'Mofiqul/dracula.nvim',
    --'dracula/vim',
        as = 'dracula',
        config = function()
            vim.cmd('colorscheme dracula')
            vim.cmd('source $HOME/.config/nvim/vimscript/barbar/barbar_settings.vim') -- Add barbar colorscheme-specific settings
            vim.cmd[[hi Normal guibg=NONE ctermbg=NONE]]    --Make background transparent
            vim.g.dracula_transparent_bg = true
            
            -- Custom Folder Icon Hi Link
            vim.cmd[[highlight NvimTreeFolderIcon guifg='#c09553']]
        end
    }

    use 'terryma/vim-multiple-cursors'
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
    use 'jacoborus/tender.vim'
    use 'machakann/vim-sandwich'
    use 'lervag/vimtex'

    --Added for NVIM 0.5:
    --use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
    use 'romgrk/barbar.nvim'
    use 'karb94/neoscroll.nvim'
    use 'kyazdani42/nvim-tree.lua'
    use 'sindrets/diffview.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
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

    use 'glepnir/dashboard-nvim'
    use 'folke/which-key.nvim'
    use 'glepnir/lspsaga.nvim'
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
        "SmiteshP/nvim-gps",
        requires = "nvim-treesitter/nvim-treesitter"
    }

    use { 
    "vhyrro/neorg",
    config = function()
        local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

        parser_configs.norg = {
            install_info = {
                url = "https://github.com/vhyrro/tree-sitter-norg",
                files = { "src/parser.c" },
                branch = "main"
            },
        }

        require('neorg').setup {
            -- Tell Neorg what modules to load
            load = {
                ["core.defaults"] = {}, -- Load all the default modules
                ["core.norg.concealer"] = {}, -- Allows for use of icons
                ["core.norg.dirman"] = { -- Manage your directories with Neorg
                    config = {
                        workspaces = {
                            my_workspace = "~/neorg"
                        }
                    }
                }
            },
        }
        end,
        requires = "nvim-lua/plenary.nvim"
    }

    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
    }

    use 'onsails/lspkind-nvim'
    use 'ray-x/lsp_signature.nvim'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    --use 'wfxr/minimap.vim'
    --use 'p00f/nvim-ts-rainbow'
    use 'tpope/vim-surround'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'chrisbra/csv.vim'
    --use 'numtostr/FTerm.nvim'

    --Too buggy:
    --use 'mfussenegger/nvim-jdtls'
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
    use 'iamcco/markdown-preview.nvim'
    use 'dkarter/bullets.vim'
    use 'ellisonleao/glow.nvim'
    use 'yamatsum/nvim-cursorline'
end)
