return {
    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        ft = { 'rust' },
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- LSP Support
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Autocompletion
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',

            -- Snippets
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',

            -- extras
            "SmiteshP/nvim-navic",
            "Decodetalkers/csharpls-extended-lsp.nvim",

            -- rust
            'mrcjkb/rustaceanvim'
        },
        config = function()
            local lsp = require("lsp-zero")

            lsp.configure('csharp_ls', {
                handlers = {
                    ["textDocument/definition"] = require("csharpls_extended").handler,
                    ["textDocument/typeDefinition"] = require("csharpls_extended").handler
                }
            })

            lsp.configure('clangd', {
                cmd = { 'clangd', '--offset-encoding=utf-16' },
            })
            -- this code makes it so that the css language server doesn't complain about tailwindcss classes
            lsp.configure("cssls", {
                settings = {
                    css = {
                        lint = { unknownAtRules = "ignore" }
                    },
                    scss = {
                        lint = { unknownAtRules = "ignore" }
                    },
                    less = {
                        lint = { unknownAtRules = "ignore" }
                    }
                }
            })
            --
            -- lsp.configure("rust_analyzer", {
            --     settings = {
            --         ["rust-analyzer"] = {
            --             checkOnSave = true,
            --             check = {
            --                 command = "clippy"
            --             }
            --         }
            --     }
            -- })



            local cmp = require('cmp')
            local cmp_action = lsp.cmp_action()
            local cmp_format = lsp.cmp_format()

            require('luasnip.loaders.from_vscode').lazy_load()

            vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

            cmp.setup({
                formatting = cmp_format,
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },
                window = {
                    documentation = cmp.config.window.bordered(),
                },
                sources = {
                    { name = 'path' },
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'buffer',  keyword_length = 3 },
                    { name = 'luasnip', keyword_length = 2 },
                },
                mapping = cmp.mapping.preset.insert({
                    -- confirm completion item
                    ['<CR>'] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Insert }),
                    ['<Tab>'] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace }),

                    -- toggle completion menu
                    ['<C-e>'] = cmp_action.toggle_completion(),

                    -- tab complete
                    -- ['<Tab>'] = cmp_action.tab_complete(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),

                    -- navigate between snippet placeholder
                    ['<C-d>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

                    -- scroll documentation window
                    ['<C-f>'] = cmp.mapping.scroll_docs(5),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-5),
                }),
            })


            local navic = require("nvim-navic")

            lsp.on_attach(function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }
                lsp.default_keymaps({ buffer = bufnr })
                vim.lsp.inlay_hint.enable(true)
                if client.server_capabilities.documentSymbolProvider then
                    navic.attach(client, bufnr)
                end
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "<leader>dc", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>ed", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                -- for the code action key map to work you need to change key binding('.' symbol) of your terminal, otherwise it won't work
                vim.keymap.set("n", "<C-.>", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                -- sometimes lsp fails, we can restart it with this keymap
                vim.keymap.set('n', "<leader>lr", vim.cmd.LspRestart, opts)
            end)

            require("mason").setup({});
            require("mason-lspconfig").setup({
                ensure_installed = { 'tsserver', 'svelte', 'lua_ls', 'csharp_ls' },
                handlers = {
                    lsp.default_setup,
                    lua_ls = function()
                        local lua_opts = lsp.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                    rust_analyzer = lsp.noop,
                    fsautocomplete = lsp.noop,
                }
            })


            lsp.set_sign_icons({
                error = '✘',
                warn = '▲',
                hint = '⚑',
                info = ''
            })

            vim.diagnostic.config({
                virtual_text = false,
                severity_sort = true,
                float = {
                    style = 'minimal',
                    border = 'rounded',
                    source = 'always',
                    header = '',
                    prefix = '',
                },
            })

            vim.g.rustaceanvim = {
                server = {
                    -- capabilities = lsp.get_capabilities(),
                    on_attach = function()
                        local bufnr = vim.api.nvim_get_current_buf()
                        vim.keymap.set("n", "<C-.>", function() vim.cmd.RustLsp('codeAction') end,
                            { silent = true, buffer = bufnr, remap = true })
                    end
                },

            }
        end
    }
}
