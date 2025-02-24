local sql_ft = { "sql", "mysql", "plsql" }
return {
    {
        'kristijanhusak/vim-dadbod-completion',
        ft = sql_ft,
        dependencies = { 'tpope/vim-dadbod', lazy = true },
        lazy = true,
    },
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies =
        {
            { 'tpope/vim-dadbod',                    lazy = true },
            { 'kristijanhusak/vim-dadbod-completion' },
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
        end,
    }
}
