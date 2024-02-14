return {
    "github/copilot.vim",
    config = function()
        vim.g.copilot_no_tab_map = true
        vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
        vim.g.copilot_filetypes = {
            -- because i'm learning rust
            rust = false
        };
    end
}
