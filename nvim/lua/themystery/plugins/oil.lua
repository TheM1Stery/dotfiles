return {
    {
        'stevearc/oil.nvim',
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({
                delete_to_trash = true,
                view_options = {
                    show_hidden = true,
                },
                win_options = {
                    signcolumn = "yes:2",
                },
                keymaps = {
                    ["<C-p"] = false
                }
            })

            vim.keymap.set("n", "<leader>tf", vim.cmd.Oil);
            vim.keymap.set("n", "<leader>tt", require("oil").toggle_float);
        end
    },
    {
        "refractalize/oil-git-status.nvim",

        dependencies = {
            "stevearc/oil.nvim",
        },

        config = true,
    },
}
