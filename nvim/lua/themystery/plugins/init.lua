return {
    "nvim-lua/plenary.nvim",
    {
        "github/copilot.vim",
        config = function()
            vim.g.copilot_no_tab_map = true
            vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"
    },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
    },
    "lewis6991/gitsigns.nvim",
    "windwp/nvim-ts-autotag",
    "windwp/nvim-autopairs",
    {
        "kosayoda/nvim-lightbulb",
        opts = {
            autocmd = { enabled = true }
        }
    },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    "mfussenegger/nvim-dap",
    "folke/neodev.nvim",
    {
        "ionide/Ionide-vim",
        event = "VimEnter"
    },
    {
        'ggandor/leap.nvim',
        dependencies = { 'tpope/vim-repeat' },
        config = function()
            require('leap').create_default_mappings()
        end
    },
    "SmiteshP/nvim-navic",
    "Decodetalkers/csharpls-extended-lsp.nvim",
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- LSP Support
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Autocompletion
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',

            -- Snippets
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
        }
    }

}
