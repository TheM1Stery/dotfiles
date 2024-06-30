return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})


        local actions = require('telescope.actions')

        require('telescope').setup {
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_cursor {}
                },
            },
            defaults = {
                mappings = {
                    i = {
                        ["<C-s>"] = actions.select_vertical,
                    },
                    n = {
                        ["<C-s>"] = actions.select_vertical,
                    },
                },
            },
            pickers = {
                find_files = {
                    theme = "dropdown"
                },
                git_files = {
                    theme = "dropdown"
                },
                grep_string = {
                    theme = "dropdown"
                },
                buffers = {
                    theme = "dropdown",
                    mappings = {
                        n = {
                            ['<C-d>'] = actions.delete_buffer
                        },
                        i = {
                            ['<C-d>'] = actions.delete_buffer
                        }
                    }
                },
            }
        }
        require("telescope").load_extension("ui-select")
    end
}
