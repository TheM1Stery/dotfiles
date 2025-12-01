return {
    {
        "ionide/Ionide-vim",
        ft = { "fsharp" }
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^6', -- Recommended
        ft = { 'rust' },
        lazy = false
    },
    {
        'saecki/crates.nvim',
        event = { "BufRead Cargo.toml" },
        tag = 'stable',
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
        branch = "treesitter-main",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            dap_debug_keymap = false
        },
        config = function(lp, opts)
            require("go").setup(opts)
            -- local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
            -- vim.api.nvim_create_autocmd("BufWritePre", {
            --     pattern = "*.go",
            --     callback = function()
            --         require('go.format').goimports()
            --     end,
            --     group = format_sync_grp,
            -- })
        end,
        event = { "CmdlineEnter" },
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
        -- cool plugin
        "chrisgrieser/nvim-lsp-endhints",
        event = "LspAttach",
        opts = {}, -- required, even if empty
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Mason
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Autocompletion
            'saghen/blink.cmp',
        },
        config = function()
            -- unknown filetypes(needed for some lsp servers)
            vim.filetype.add {
                pattern = {
                    ['.*/hypr/.*%.conf'] = 'hyprlang',
                    ['openapi.*%.ya?ml'] = 'yaml.openapi',
                    ['openapi.*%.json'] = 'json.openapi',
                    ['%.gitlab%-ci%.ya?ml'] = 'yaml.gitlab',
                }
            }



            vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

            local lspconfig_defaults = require('lspconfig').util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lspconfig_defaults.capabilities,
                require('blink.cmp').get_lsp_capabilities()
            )



            -- stole this from kickstart.nvim
            local function client_supports_method(client, method, bufnr)
                if vim.fn.has 'nvim-0.11' == 1 then
                    return client:supports_method(method, bufnr)
                else
                    return client.supports_method(method, { bufnr = bufnr })
                end
            end

            local map = function(keys, func, desc, mode, event)
                mode = mode or 'n'
                vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
            end

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(event)
                    local opts = { buffer = event.buf, remap = false }
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                        map('<leader>th', function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                        end, '[T]oggle Inlay [H]ints', nil, event)
                    end
                    -- if client and client.server_capabilities.documentSymbolProvider then
                    --     navic.attach(client, event.buf)
                    -- end
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

                    -- vim.keymap.set("n", "<leader>nv", function() navbuddy.open() end, opts)
                end
            })


            local gopls_cfg = require("go.lsp").config()
            vim.lsp.config.gopls = gopls_cfg



            vim.lsp.config("yamlls", {
                settings = {
                    yaml = {
                        customTags = { "!reference sequence" }
                    }
                }
            })

            vim.lsp.config("clangd", {
                cmd = { 'clangd', '--offset-encoding=utf-16' },
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }, -- exclude "proto".
            })

            vim.lsp.config("cssls", {
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

            vim.lsp.config("tailwindcss", {
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
            })

            vim.lsp.config("gdscript", {
                cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
            })

            require("mason").setup({
                registries = {
                    'github:mason-org/mason-registry',
                    'github:Crashdummyy/mason-registry'
                }
            });
            require("mason-lspconfig").setup({
                ensure_installed = { 'ts_ls', 'svelte', 'lua_ls', 'rust_analyzer', 'gopls' },
                automatic_installation = false,
                automatic_enable = {
                    exclude = { "rust_analyzer", "fsautocomplete" }
                }
            })
            vim.lsp.enable("gdscript")



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
