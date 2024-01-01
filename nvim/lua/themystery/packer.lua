-- This file can be loaded by calling `lua require('plugins')` from your init.vimpacke

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- use({
    --  'rose-pine/neovim',
    --  as = 'rose-pine',
    --  config = function()
    --   vim.cmd('colorscheme rose-pine')
    --  end
    -- })

    use 'numToStr/Comment.nvim'

    -- use 'navarasu/onedark.nvim'
    use "olimorris/onedarkpro.nvim"


    -- use 'folke/tokyonight.nvim'

    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    })


    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("nvim-treesitter/playground")
    use("theprimeagen/refactoring.nvim")
    use("mbbill/undotree")
    use("tpope/vim-fugitive")
    use("nvim-treesitter/nvim-treesitter-context");

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    use("folke/zen-mode.nvim")
    use("github/copilot.vim")
    -- use("zbirenbaum/copilot.lua")


    use("eandrju/cellular-automaton.nvim")
    use("laytan/cloak.nvim")
    -- use {
    --     'nvim-tree/nvim-tree.lua',
    --     requires = {
    --         'nvim-tree/nvim-web-devicons', -- optional
    --     },
    -- }

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    }


    use('lewis6991/gitsigns.nvim')

    use('windwp/nvim-ts-autotag')

    use('theprimeagen/vim-be-good')

    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use 'andweeb/presence.nvim'

    -- use {'romgrk/barbar.nvim', requires = {
    --   'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    --   'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    -- }
    -- }

    use {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup({
                theme = "hyper",
                config = {
                    project = {
                        action = function(path)
                            vim.cmd('Neotree dir=')
                        end,
                    },
                }
            })
        end,
        requires = { 'nvim-tree/nvim-web-devicons' }
    }

    use({
        "utilyre/barbecue.nvim",
        tag = "*",
        requires = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        after = "nvim-web-devicons",       -- keep this if you're using NvChad
        config = function()
            require("barbecue").setup({
                attach_navic = false
            })
        end,
    })

    use { 'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons' }

    use { 'kosayoda/nvim-lightbulb' }

    use "lukas-reineke/indent-blankline.nvim"

    use { 'nvim-telescope/telescope-ui-select.nvim' }

    use 'mfussenegger/nvim-dap'

    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

    use { "folke/neodev.nvim" }

    use { "folke/noice.nvim", requires = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" } }

    use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }

    use { '3rd/image.nvim' }

    use { 'ionide/Ionide-vim', event = 'VimEnter' }

    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    use ({
        'ggandor/leap.nvim',
        requires = { 'tpope/vim-repeat' },
        config = function ()
            require('leap').create_default_mappings()
        end
    })
end)
