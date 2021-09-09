return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'preservim/nerdcommenter'

    -- Change colorscheme here and adjust sources/configs as such
    use {'dracula/vim',
        as = 'dracula',
        config = function()
            vim.cmd('colorscheme dracula')
            vim.cmd('source $HOME/.config/nvim/vimscript/barbar/barbar_settings.vim') -- Add barbar colorscheme-specific settings
            vim.cmd[[hi Normal guibg=NONE ctermbg=NONE]]    --Make background transparent
        end
    }

    use 'terryma/vim-multiple-cursors'
    use 'tpope/vim-fugitive'
    use 'prabirshrestha/async.vim'
    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'
    use 'jceb/vim-orgmode'
    use 'Xuyuanp/nerdtree-git-plugin'
    use 'tiagofumo/vim-nerdtree-syntax-highlight'
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
    use 'romgrk/barbar.nvim'
    use 'psliwka/vim-smoothie'
    use 'kyazdani42/nvim-tree.lua'
    use 'TimUntersberger/neogit'
    use 'nvim-lua/plenary.nvim'
    use 'neovim/nvim-lspconfig'
    use 'kabouzeid/nvim-lspinstall'
    use 'nvim-lua/completion-nvim'
    --use 'neoclide/coc.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-lua/popup.nvim'
    use 'nvim-telescope/telescope.nvim'
    --use 'kosayoda/nvim-lightbulb'
    use {'glepnir/galaxyline.nvim', branch = 'main'}
    use 'glepnir/dashboard-nvim'
    use 'folke/which-key.nvim'
    --use 'glepnir/lspsaga.nvim'
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
    use 'wfxr/minimap.vim'
    use 'p00f/nvim-ts-rainbow'
    use 'tpope/vim-surround'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'chrisbra/csv.vim'
    use 'numtostr/FTerm.nvim'
end)
