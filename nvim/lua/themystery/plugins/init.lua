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
        event = "VimEnter",
        enabled = false
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
}
