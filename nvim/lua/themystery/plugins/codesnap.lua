return {
    "mistricky/codesnap.nvim",
    config = function()
        require("codesnap").setup({
            mac_window_bar = false,
            watermark = "TheMystery",
            has_breadcrumbs = true,
            bg_theme = "grape"
        })
    end,
    build = "make"
}
