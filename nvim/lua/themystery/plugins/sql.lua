local sql_ft = { "sql", "mysql", "plsql" }
return {
    {
        'kristijanhusak/vim-dadbod-completion',
        ft = sql_ft,
        dependencies = { 'tpope/vim-dadbod', lazy = true },
        lazy = true,
        init = function()
            -- vim.api.nvim_create_autocmd("FileType", {
            --     pattern = {
            --         "sql",
            --     },
            --     command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
            -- })

            -- taken from here https://github.com/kristijanhusak/vim-dadbod-completion/issues/53#issuecomment-1902659351
            local autocomplete_group = vim.api.nvim_create_augroup("vimrc_autocompletion", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = sql_ft,
                callback = function()
                    local cmp = require("cmp")
                    local global_sources = cmp.get_config().sources
                    local buffer_sources = {}

                    -- add globally defined sources (see separate nvim-cmp config)
                    -- this makes e.g. luasnip snippets available since luasnip is configured globally
                    if global_sources then
                        for _, source in ipairs(global_sources) do
                            table.insert(buffer_sources, { name = source.name })
                        end
                    end

                    -- add vim-dadbod-completion source
                    table.insert(buffer_sources, { name = "vim-dadbod-completion" })

                    -- update sources for the current buffer
                    cmp.setup.buffer({ sources = buffer_sources })
                end,
                group = autocomplete_group,
            })
        end
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
