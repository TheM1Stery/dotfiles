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
        'ggandor/leap.nvim',
        dependencies = { 'tpope/vim-repeat' },
        config = function()
            vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)')
            vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)')
            vim.keymap.set('n', 'gs', '<Plug>(leap-from-window)')
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
    },
    {
        'stevearc/overseer.nvim',
        ---@module 'overseer'
        ---@type overseer.SetupOpts
        opts = {},
    },
}
