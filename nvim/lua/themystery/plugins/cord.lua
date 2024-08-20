return {
    'vyfor/cord.nvim',
    enabled = false,
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
            idle = {
                enable = true, -- Enable idle status
                show_status = true, -- Display idle status, disable to hide the rich presence on idle
                timeout = 300000, -- Timeout in milliseconds after which the idle status is set, 0 to display immediately
                disable_on_focus = false, -- Do not display idle status when neovim is focused
                text = 'Idle', -- Text to display when idle
                tooltip = '💤', -- Text to display when hovering over the idle image
            },
        })
    end
}
