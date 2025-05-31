local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    --> Aesthetic
    { "nvim-lualine/lualine.nvim", lazy = false, dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "andweeb/presence.nvim" },
    { "nvimdev/dashboard-nvim", lazy = false, dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "ya2s/nvim-cursorline" },
    { "lewis6991/hover.nvim" },

    --> Themes
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "marko-cerovac/material.nvim" },
    { "EdenEast/nightfox.nvim" },
    { "yorumicolors/yorumi.nvim" },
    { "scottmckendry/cyberdream.nvim" },

    --> Functional
    { "nvim-tree/nvim-web-devicons", opts = {} },
    { "nvim-telescope/telescope.nvim", tag = "0.1.5", dependencies = { "nvim-lua/plenary.nvim" } },
    { "Exafunction/codeium.nvim", dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" } },
    { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    --{ "lewis6991/gitsigns.nvim" },
    { "stevearc/oil.nvim", dependencies = { { "echasnovski/mini.icons", opts = {} } } },
    { "windwp/nvim-autopairs", config = true, check_ts = true },
    -- { "ggandor/lightspeed.nvim" },
    --[[
    {
        "romgrk/barbar.nvim",
        dependencies = { "lewis6991/gitsigns.nvim", "nvim-tree/nvim-web-devicons" },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {},
        version = "^1.0.0",
    },
    ]]

    --> LSP / Codecompletion (treesitter)
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    { "nvim-treesitter/nvim-treesitter" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "L3MON4D3/LuaSnip" },
    { "lopi-py/luau-lsp.nvim", opts = {...}, dependencies = { "nvim-lua/plenary.nvim" } },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
        opts = {},
    },
})

