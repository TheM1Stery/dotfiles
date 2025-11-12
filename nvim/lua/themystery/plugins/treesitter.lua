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
            -- this config was taken
            -- from https://github.com/VonHeikemen/nvim-light/blob/main/configs/stable.lua & https://www.reddit.com/r/neovim/comments/1ou68ds/nvimtreesitter_main_rewrite_did_i_do_this_right/
            -- It looked super clean, liked it very much and it's minimal as well
            local ts = vim.treesitter
            local ts_start = function(buf, parser)
                vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                local ok, hl = pcall(ts.query.get, parser, 'highlights')
                if ok and hl then
                    ts.start(buf, parser)
                end
            end
            -- install parsers from opts.ensure_installed
            if opts.ensure_installed and #opts.ensure_installed > 0 then
                require("nvim-treesitter").install(opts.ensure_installed)
            end

            local nvim_ts = require("nvim-treesitter")
            vim.api.nvim_create_autocmd({ "FileType" }, {
                desc = 'enable treesitter',
                callback = function(event)
                    local ft = event.match
                    local lang = ts.language.get_lang(ft)
                    local is_installed, error = ts.language.add(ft)

                    local buffer = event.buf
                    if is_installed then
                        ts_start(buffer, lang)
                        return
                    end

                    -- install if not installed
                    local available_langs = nvim_ts.get_available()
                    local is_available = vim.tbl_contains(available_langs, lang)

                    if is_available then
                        nvim_ts.install(lang):await(function()
                            ts_start(buffer, lang)
                        end)
                    end
                end
            })
        end
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter"
        }
    }

}
