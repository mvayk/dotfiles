require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "clangd" },
    automatic_enable = false
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").lua_ls.setup {
    capabiltiies = capabilities,
    settings = {
       Lua = { diagnostics = { globals = { "vim" } } }
    }
}

local function is_windows()
  return vim.loop.os_uname().version:match("Windows")
end

require("lspconfig").rust_analyzer.setup {
    capabiltiies = capabilities,
}

local clangd_path = "clangd"
if is_windows() then
  local local_appdata = vim.loop.os_getenv("LOCALAPPDATA")
  clangd_path = local_appdata .. "\\nvim-data\\mason\\packages\\clangd\\clangd_20.1.0\\bin\\clangd.exe"
end

require("lspconfig").clangd.setup({
  capabilities = capabilities,
  init_options = {
      fallbackFlags = {'--std=c++20'}
  },
})

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
