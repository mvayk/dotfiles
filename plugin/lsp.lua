-- NOTE: LSP
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "clangd" }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason-lspconfig").setup_handlers {
    luau_lsp = function()
        require("luau-lsp").setup() {
            platform = {
                type = "roblox",
            },
            types = {
                roblox_security_level = "PluginSecurity",
            },

            server = {
                server = {
                    capabiltiies = capabilities,
                },
                settings = {
                    ["luau-lsp"] = {
                        completion = {
                            imports = {
                                enabled = true,
                            }
                        }
                    }
                }
            }
        }
    end,
}

require("luau-lsp").config {...}

require("lspconfig").lua_ls.setup {
    capabiltiies = capabilities,
    settings = {
       Lua = { diagnostics = { globals = { "vim" } } }
    }
}

-- NOTE: this might not be needed
require("lspconfig").clangd.setup {
    capabiltiies = capabilities
}

require("lspconfig").rust_analyzer.setup {
    capabiltiies = capabilities
}

-- NOTE: Autocomplete
local cmp = require("cmp")

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),

    completion = {
        debounce = 0,
    },

    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },

    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = "luasnip" },
    }, {
        { name = 'buffer' },
    }),
})
