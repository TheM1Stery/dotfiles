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
    {
        "lewis6991/gitsigns.nvim",
        opts = {}
    },
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        opts = {}
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}
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
        "folke/neodev.nvim",
        dependencies = { "rcarriga/nvim-dap-ui" },
        config = function()
            require("neodev").setup({
                library = { plugins = { "nvim-dap-ui" }, types = true }
            })
        end
    },
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
    "HiPhish/rainbow-delimiters.nvim",
}
