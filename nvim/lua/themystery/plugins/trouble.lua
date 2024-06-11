return {
    "folke/trouble.nvim",
    config = function()
        require("trouble").setup()
        vim.keymap.set("n", "<leader>xq", "<cmd>Trouble diagnostics toggle focus=false<cr>",
            { silent = true, noremap = true }
        )
    end
}
