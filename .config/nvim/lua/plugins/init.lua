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
    -- colorscheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({ flavour = "mocha" })
            vim.cmd.colorscheme("catppuccin")
        end,
    },

    -- lualine
    {
        "nvim-lualine/lualine.nvim",
        lazy = true,
        event = { "BufReadPost", "BufAdd", "BufNewFile" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = require("plugins.lualine"),
    },

    -- bufferline
    {
        "akinsho/bufferline.nvim",
        lazy = true,
        event = { "BufReadPost", "BufAdd", "BufNewFile" },
        config = function()
            require("bufferline").setup({
                highlights = require("catppuccin.groups.integrations.bufferline").get(),
            })
        end,
    },

    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = true,
        event = "BufReadPre",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            { "hiphish/rainbow-delimiters.nvim" },
        },
        config = require("plugins.treesitter"),
    },

    -- blankline
    {
        "lukas-reineke/indent-blankline.nvim",
        lazy = true,
        event = { "CursorHold", "CursorHoldI" },
        config = function()
            local hooks = require("ibl.hooks")
            hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
            require("ibl").setup({})
        end,
    },

    -- lspconfig
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        event = { "BufReadPost", "BufAdd", "BufNewFile" },
        config = require("plugins.lsp"),
    },

    -- completion
    {
        "hrsh7th/nvim-cmp",
        lazy = true,
        event = "InsertEnter",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                dependencies = { { "rafamadriz/friendly-snippets" } },
                config = function()
                    require("luasnip.loaders.from_vscode").load()
                end,
            },
            { "hrsh7th/cmp-buffer" },
            {
                "uga-rosa/cmp-dictionary",
                opts = { paths = { "/usr/share/dict/words" }, exact_length = 2, first_case_insensitive = true },
            },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lsp-signature-help" },
            { "hrsh7th/cmp-nvim-lua" },
            { "hrsh7th/cmp-path" },
            { "onsails/lspkind-nvim" },
            { "saadparwaiz1/cmp_luasnip" },
        },
        config = require("plugins.cmp"),
    },

    -- comment
    {
        "numToStr/Comment.nvim",
        lazy = true,
        event = { "CursorHold", "CursorHoldI" },
        opts = {},
    },

    -- autoclose
    {
        "m4xshen/autoclose.nvim",
        lazy = true,
        event = "InsertEnter",
        opts = {},
    },

    -- better-escape
    {
        "max397574/better-escape.nvim",
        lazy = true,
        event = "InsertEnter",
        opts = {},
    },

    -- neoscroll
    {
        "karb94/neoscroll.nvim",
        lazy = true,
        event = { "CursorHold", "CursorHoldI" },
        opts = {},
    },

    -- format code
    {
        "sbdchd/neoformat",
        lazy = true,
        keys = {
            { "<leader>fc", "<cmd>Neoformat<CR>", desc = "neoformat" },
        },
    },

    -- easymotion-like
    {
        "phaazon/hop.nvim",
        lazy = true,
        keys = {
            { "<leader>h", "<cmd>HopChar2<CR>", desc = "hop.nvim" },
        },
        opts = {},
    },

    -- startup time
    {
        "dstein64/vim-startuptime",
        lazy = true,
        cmd = "StartupTime",
        init = function()
            vim.g.startuptime_tries = 10
        end,
    },
})

require("plugins.keymap")
