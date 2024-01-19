return {
    "olimorris/onedarkpro.nvim",
    dependencies = { "lukas-reineke/indent-blankline.nvim" },
    priority = 1000,
    config = function()
        require("onedarkpro").setup({
            options = {
                transparency = true,
            }
        })

        vim.cmd("colorscheme onedark_vivid")
    end
}
