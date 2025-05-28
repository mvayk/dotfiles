local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    --> Aesthetic
    {"nvim-lualine/lualine.nvim", dependencies = {"nvim-tree/nvim-web-devicons"}},
    {"andweeb/presence.nvim"},
    {"scottmckendry/cyberdream.nvim"},
    {"nvimdev/dashboard-nvim", event = "VimEnter", dependencies = {{"nvim-tree/nvim-web-devicons"}}},
    {"marko-cerovac/material.nvim"},
    {"EdenEast/nightfox.nvim"},
    {"ya2s/nvim-cursorline"},
    {"catppuccin/nvim", name = "catppuccin", priority = 1000},
    {"ggandor/lightspeed.nvim"},
    {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    },

    --> Functional
    {"nvim-tree/nvim-web-devicons", opts = {}},
    {"nvim-telescope/telescope.nvim", tag = "0.1.5", dependencies = {"nvim-lua/plenary.nvim"}},
    {"Exafunction/codeium.nvim", dependencies = {"nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp"}},
    {"folke/todo-comments.nvim", dependencies = {"nvim-lua/plenary.nvim"}},
    {"lewis6991/gitsigns.nvim"},
    {"stevearc/oil.nvim", dependencies = {{"echasnovski/mini.icons", opts = {}}},},
    {"windwp/nvim-autopairs", config = true, check_ts = true},
    {"romgrk/barbar.nvim", dependencies = {"lewis6991/gitsigns.nvim", "nvim-tree/nvim-web-devicons"},
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {},
        version = "^1.0.0",
    },
    {"lewis6991/hover.nvim"},

    --> LSP / Codecompletion (treesitter)
    {"williamboman/mason.nvim"},
    {"williamboman/mason-lspconfig.nvim"},
    {"neovim/nvim-lspconfig"},
    {"nvim-treesitter/nvim-treesitter"},
    {"hrsh7th/nvim-cmp"},
    {"hrsh7th/cmp-nvim-lsp"},
    {"L3MON4D3/LuaSnip"},
    {"lopi-py/luau-lsp.nvim", opts = {...}, dependencies = {"nvim-lua/plenary.nvim"}},
})
