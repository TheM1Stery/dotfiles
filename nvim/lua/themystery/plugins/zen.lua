return {
    "folke/zen-mode.nvim",
    config = function()
        require("zen-mode").setup {
        }

        vim.keymap.set("n", "<leader>ze", ":ZenMode<CR>")
    end
}
