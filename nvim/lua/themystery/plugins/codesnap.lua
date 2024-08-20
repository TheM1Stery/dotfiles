return {
    "mistricky/codesnap.nvim",
    config = function()
        require("codesnap").setup({
            mac_window_bar = false,
            watermark = "TheMystery",
            has_breadcrumbs = true,
            bg_theme = "grape",
            has_line_number = true
        })

        vim.keymap.set("v", "<leader>cc", "<cmd>CodeSnap<cr>")
    end,
    build = "make"
}
