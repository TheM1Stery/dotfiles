return {
    {
        "mistweaverco/kulala.nvim",
        keys = {
            { "<leader>Rs", desc = "Send request" },
            { "<leader>Ra", desc = "Send all requests" },
            { "<leader>Rb", desc = "Open scratchpad" },
        },
        ft = { "http", "rest", "json" },
        opts = {
            global_keymaps = true,
            global_keymaps_prefix = "<leader>R",
            kulala_keymaps_prefix = "",
            lsp = {
                enable = true,
                filetypes = { "http", "rest", "json", "yaml", "bruno" },
                keymaps = false, -- disabled by default, as Kulala relies on default Neovim LSP keymaps
                formatter = {
                    sort = {     -- enable/disable alphabetical sorting
                        metadata = true,
                        variables = true,
                        commands = false,
                        json = true,
                    },
                    quote_json_variables = true, -- add quotes around {{variable}} in JSON bodies
                    indent = 2,                  -- base indentation for scripts
                    lsp = {
                        formatter = true
                    }
                },
            },
        },
    },
}
