return {
    'vyfor/cord.nvim',
    build = './build',
    event = 'VeryLazy',
    config = function()
        require('cord').setup({
            timer = {
                enable = true,           -- Enable automatically updating presence
                interval = 1500,         -- Interval between presence updates in milliseconds (min 500)
                reset_on_idle = true,    -- Reset start timestamp on idle
                reset_on_change = false, -- Reset start timestamp on presence change
            },
            text = {
                viewing = 'Viewing {}',                    -- Text to display when viewing a readonly file
                editing = 'Editing {}',                    -- Text to display when editing a file
                file_browser = 'Browsing files in {}',     -- Text to display when browsing files (Empty string to disable)
                plugin_manager = 'Managing plugins in {}', -- Text to display when managing plugins (Empty string to disable)
                lsp_manager = 'Configuring LSP in {}',     -- Text to display when managing LSP servers (Empty string to disable)
                workspace = '',
            },
            display = {
                show_time = true,             -- Display start timestamp
                show_repository = false,      -- Display 'View repository' button linked to repository url, if any
                show_cursor_position = false, -- Display line and column number of cursor's position
                swap_fields = false,          -- If enabled, workspace is displayed first
                workspace_blacklist = {},     -- List of workspace names to hide
            },
        })
    end
}
