local rust = {
    {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recommended
        ft = { 'rust' },
        lazy = false
    },
    {
        'saecki/crates.nvim',
        event = { "BufRead Cargo.toml" },
        config = function()
            require('crates').setup({
                lsp = {
                    enabled = true,
                    actions = true,
                    completion = true,
                    hover = true
                }
            })
            local opts = { silent = true }


            local crates = require("crates")

            vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)
            vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
        end,
    },
}

local go = {
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
        },
        ft = { "go", 'gomod' },
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
}

local lazydev = {
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
}

return {
    lazydev,
    rust,
    go,
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
            "SmiteshP/nvim-navbuddy",
            "Decodetalkers/csharpls-extended-lsp.nvim",

            -- specific language servers
            'mrcjkb/rustaceanvim',
            'ray-x/go.nvim',
        },
        config = function()
            -- unknown filetypes(needed for some lsp servers)
            vim.filetype.add {
                pattern = {
                    ['.*/hypr/.*%.conf'] = 'hyprlang',
                    ['openapi.*%.ya?ml'] = 'yaml.openapi',
                    ['openapi.*%.json'] = 'json.openapi',
                }
            }


            local lsp = require("lsp-zero")

            local cmp = require('cmp')
            local cmp_action = lsp.cmp_action()

            require('luasnip.loaders.from_vscode').lazy_load()

            local tailwindcss_colors = require('tailwindcss-colorizer-cmp')

            local cmp_formatter = function(entry, vim_item)
                -- vim_item as processed by tailwindcss-colorizer-cmp
                vim_item = tailwindcss_colors.formatter(entry, vim_item)

                -- change menu (name of source)
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    buffer = "[Buffer]",
                    path = "[Path]",
                    emoji = "[Emoji]",
                    luasnip = "[LuaSnip]",
                    vsnip = "[VSCode Snippet]",
                    calc = "[Calc]",
                    spell = "[Spell]",
                })[entry.source.name]
                return vim_item
            end

            vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

            cmp.setup({
                formatting = {
                    fields = { "abbr", "menu", "kind" },
                    format = cmp_formatter,
                },
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                sources = {
                    { name = 'path' },
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'buffer',  keyword_length = 3 },
                    { name = 'luasnip', keyword_length = 2 },
                    { name = 'lazydev', group_index = 0 }
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

            local lspconfig_defaults = require('lspconfig').util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lspconfig_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )



            local navic = require("nvim-navic")

            local navbuddy = require("nvim-navbuddy")

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(event)
                    local opts = { buffer = event.buf, remap = false }
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    vim.lsp.inlay_hint.enable(true)
                    if client and client.server_capabilities.documentSymbolProvider then
                        navic.attach(client, event.buf)
                        navbuddy.attach(client, event.buf)
                    end
                    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
                    vim.keymap.set("n", "<leader>dc", function() vim.lsp.buf.hover() end, opts)
                    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                    vim.keymap.set("n", "<leader>ed", function() vim.diagnostic.open_float() end, opts)
                    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                    -- for the code action key map to work you need to change key binding('.' symbol) of your terminal, otherwise it won't work
                    vim.keymap.set("n", "<C-.>", function() vim.lsp.buf.code_action() end, opts)
                    vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts)
                    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                    -- sometimes lsp fails, we can restart it with this keymap
                    vim.keymap.set('n', "<leader>lr", vim.cmd.LspRestart, opts)

                    vim.keymap.set("n", "<leader>nv", function() navbuddy.open() end, opts)
                end
            })

            require("go").setup({
                lsp_cfg = false
            })

            local noop = function() end

            local gopls_opts = require("go.lsp").config()
            local handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup {}
                end,
                -- lua_ls = function()
                --     local lua_opts = lsp.nvim_lua_ls()
                --     require('lspconfig').lua_ls.setup(lua_opts)
                -- end,
                rust_analyzer = noop,
                fsautocomplete = noop,
                gopls = function()
                    require('lspconfig').gopls.setup(gopls_opts)
                end,
                yamlls = function()
                    require('lspconfig').yamlls.setup {
                        filetypes = { 'yaml', 'yaml.openapi' }
                    }
                end,
                csharp_ls = function()
                    require("lspconfig").csharp_ls.setup {
                        handlers = {
                            ["textDocument/definition"] = require("csharpls_extended").handler,
                            ["textDocument/typeDefinition"] = require("csharpls_extended").handler
                        }
                    }
                end,
                clangd = function()
                    require("lspconfig").clangd.setup {
                        cmd = { 'clangd', '--offset-encoding=utf-16' },
                    }
                end,
                cssls = function()
                    require("lspconfig").cssls.setup {
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
                    }
                end,
                tailwindcss = function()
                    require("lspconfig").tailwindcss.setup {
                        filetypes = {
                            "astro",
                            "handlebars",
                            "html",
                            "javascript",
                            "javascriptreact",
                            "svelte",
                            "typescript",
                            "typescriptreact",
                            "rust",
                            "templ"
                        },
                        init_options = { userLanguages = { rust = "html", templ = "html" } },
                    }
                end
            }

            require("mason").setup();
            require("mason-lspconfig").setup({
                ensure_installed = { 'ts_ls', 'svelte', 'lua_ls', 'csharp_ls', 'rust_analyzer', 'gopls' },
                handlers = handlers,
                automatic_installation = false
            })


            vim.diagnostic.config({
                virtual_text = false,
                severity_sort = true,
                signs = vim.g.have_nerd_font and {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '✘',
                        [vim.diagnostic.severity.WARN] = '▲',
                        [vim.diagnostic.severity.HINT] = '⚑',
                        [vim.diagnostic.severity.INFO] = ''

                    }
                } or {},
                float = {
                    style = 'minimal',
                    border = 'rounded',
                    source = true,
                    header = '',
                    prefix = '',
                },
            })
        end
    }
}
