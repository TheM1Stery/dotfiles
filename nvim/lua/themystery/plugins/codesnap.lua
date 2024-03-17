return {
    "mistricky/codesnap.nvim",
    config = function()
        vim.keymap.set("n", "<leader>csv", "<cmd>CodeSnapPreviewOn<CR>")
        require("codesnap").setup({
            mac_window_bar = false,
            opacity = true,
            watermark = "TheMystery"
        })
    end,
    build = "make"
}
