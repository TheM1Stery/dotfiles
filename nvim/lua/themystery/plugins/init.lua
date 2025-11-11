return {
    "nvim-lua/plenary.nvim",
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
    },
    {
        "kosayoda/nvim-lightbulb",
        opts = {
            autocmd = { enabled = true }
        }
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup()
        end
    },
    "mfussenegger/nvim-dap",
    {
        "ionide/Ionide-vim",
        event = "VimEnter",
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
        'MeanderingProgrammer/markdown.nvim',
        main = "render-markdown",
        opts = {},
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    },
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp"
    },
    "tpope/vim-dotenv",
    {
        "olimorris/persisted.nvim",
        lazy = false, -- make sure the plugin is always loaded at startup
        config = true
    },
    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
        enabled = vim.fn.has("nvim-0.10.0") == 1,
    }
}
