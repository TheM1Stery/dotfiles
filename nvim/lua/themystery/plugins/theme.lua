-- return {
--     "olimorris/onedarkpro.nvim",
--     dependencies = { "lukas-reineke/indent-blankline.nvim" },
--     priority = 1000,
--     config = function()
--         require("onedarkpro").setup({
--             options = {
--                 transparency = true,
--             }
--         })
--
--         vim.cmd("colorscheme onedark_vivid")
--     end
-- }
return {
    "diegoulloao/neofusion.nvim",
    priority = 1000,
    config = function()
        vim.o.background = "dark"
        vim.cmd([[ colorscheme neofusion ]])
    end,
}
