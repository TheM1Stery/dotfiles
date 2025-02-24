return {
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
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
        },
        ft = { "go", 'gomod' },
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
    {
        "seblyng/roslyn.nvim",
        ft = "cs",
        opts = {
        }
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Mason
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Autocompletion
            'saghen/blink.cmp',

            -- extras
            "SmiteshP/nvim-navic",
            "SmiteshP/nvim-navbuddy",
            "Decodetalkers/csharpls-extended-lsp.nvim",

            -- specific language servers
            'mrcjkb/rustaceanvim',
            'ray-x/go.nvim',
            'seblyng/roslyn.nvim'
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



            vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

            local lspconfig_defaults = require('lspconfig').util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lspconfig_defaults.capabilities,
                require('blink.cmp').get_lsp_capabilities()
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

            require("mason").setup({
                registries = {
                    'github:mason-org/mason-registry',
                    'github:Crashdummyy/mason-registry'
                }
            });
            require("mason-lspconfig").setup({
                ensure_installed = { 'ts_ls', 'svelte', 'lua_ls', 'rust_analyzer', 'gopls' },
                handlers = handlers,
                automatic_installation = false
            })


            vim.diagnostic.config({
                virtual_text = false,
                severity_sort = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '✘',
                        [vim.diagnostic.severity.WARN] = '▲',
                        [vim.diagnostic.severity.HINT] = '⚑',
                        [vim.diagnostic.severity.INFO] = '󰋽'

                    }
                },
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
