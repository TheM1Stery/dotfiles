return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "main", -- master to be frozen
        build = ":TSUpdate",
        --@class TSConfig
        opts = {
            ensure_installed = { "vimdoc", "javascript", "typescript", "c", "lua", "rust", "c_sharp" }
        },
        config = function(_, opts)
            local ts_start = function(buf, parser)
                vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                vim.treesitter.start(buf, parser)
            end
            -- install parsers from opts.ensure_installed
            if opts.ensure_installed and #opts.ensure_installed > 0 then
                require("nvim-treesitter").install(opts.ensure_installed)
                -- register and start parsers for filetypes
                for _, parser in ipairs(opts.ensure_installed) do
                    local filetypes = parser -- In this case, parser is the filetype/language name
                    vim.treesitter.language.register(parser, filetypes)

                    vim.api.nvim_create_autocmd({ "FileType" }, {
                        pattern = filetypes,
                        callback = function(event)
                            ts_start(event.buf, parser)
                        end,
                    })
                end
            end

            vim.api.nvim_create_autocmd({ "FileType" }, {
                callback = function(event)
                    local bufnr = event.buf
                    local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

                    -- Skip if no filetype
                    if filetype == "" then
                        return
                    end

                    -- Check if this filetype is already handled by explicit opts.ensure_installed config
                    for _, filetypes in pairs(opts.ensure_installed) do
                        local ft_table = type(filetypes) == "table" and filetypes or { filetypes }
                        if vim.tbl_contains(ft_table, filetype) then
                            return -- Already handled above
                        end
                    end

                    -- Get parser name based on filetype
                    local parser_name = vim.treesitter.language.get_lang(filetype) -- might return filetype (not helpful)
                    if not parser_name then
                        return
                    end
                    -- Try to get existing parser (helpful check if filetype was returned above)
                    local parser_configs = require("nvim-treesitter.parsers")
                    if not parser_configs[parser_name] then
                        return -- Parser not available, skip silently
                    end

                    local parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

                    if parser_installed then
                        vim.treesitter.start(bufnr, parser_name)
                        return
                    end

                    if not parser_installed then
                        -- If not installed, install parser synchronously
                        require("nvim-treesitter").install({ parser_name }):await((
                            function()
                                ts_start(bufnr, parser_name)
                            end
                        ))
                    end
                end
            })
            require('rainbow-delimiters.setup').setup {}
        end
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter"
        }
    }

}
