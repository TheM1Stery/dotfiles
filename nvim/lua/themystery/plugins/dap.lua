return {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
        -- dap keymaps
        vim.keymap.set("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>")
        vim.keymap.set("n", "<F10>", "<cmd>lua require'dap'.step_over()<CR>")
        vim.keymap.set("n", "<F11>", "<cmd>lua require'dap'.step_into()<CR>")
        vim.keymap.set("n", "<F12>", "<cmd>lua require'dap'.step_out()<CR>")
        vim.keymap.set("n", "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
        vim.keymap.set("n", "<leader>B",
            "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
        vim.keymap.set("n", "<leader>lp",
            "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
        vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>")

        require("dapui").setup()

        -- dapui keymaps
        vim.keymap.set("n", "<leader>dui", "<cmd>lua require'dapui'.toggle()<CR>")
    end
}