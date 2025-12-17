local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        -- colorscheme
        {
            "catppuccin/nvim",
            name = "catppuccin",
            lazy = false,
            config = function()
                require("catppuccin").setup({ flavour = "mocha" })
                vim.cmd.colorscheme("catppuccin")
            end,
        },

        -- lualine
        {
            "nvim-lualine/lualine.nvim",
            event = { "BufReadPost", "BufAdd", "BufNewFile" },
            dependencies = { "nvim-tree/nvim-web-devicons" },
            config = require("plugins.lualine"),
        },

        -- bufferline
        {
            "akinsho/bufferline.nvim",
            event = { "BufReadPost", "BufAdd", "BufNewFile" },
            config = function()
                require("bufferline").setup({
                    highlights = require("catppuccin.special.bufferline").get_theme(),
                })
            end,
        },

        -- treesitter
        {
            "nvim-treesitter/nvim-treesitter",
            branch = "master",
            build = ":TSUpdate",
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
            event = { "BufReadPost", "BufAdd", "BufNewFile" },
            config = require("plugins.lsp"),
        },

        -- telescope
        {
            "nvim-telescope/telescope.nvim",
            cmd = "Telescope",
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = { defaults = { layout_config = { horizontal = { preview_width = 0.618 } } } },
        },

        -- floating terminal
        {
            "nvzone/floaterm",
            cmd = "FloatermToggle",
            dependencies = { "nvzone/volt" },
            opts = { size = { h = 75, w = 90 } },
        },

        -- completion
        {
            "hrsh7th/nvim-cmp",
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
            event = { "CursorHold", "CursorHoldI" },
            opts = {},
        },

        -- autoclose
        {
            "m4xshen/autoclose.nvim",
            event = "InsertEnter",
            opts = {},
        },

        -- neoscroll
        {
            "karb94/neoscroll.nvim",
            event = { "CursorHold", "CursorHoldI" },
            opts = {},
        },

        -- accelerated-jk
        {
            "rainbowhxch/accelerated-jk.nvim",
            event = { "CursorHold", "CursorHoldI" },
        },

        -- format code
        {
            "sbdchd/neoformat",
            cmd = "Neoformat",
            init = function()
                vim.g.shfmt_opt = "-s"
            end,
        },

        -- easymotion-like
        {
            "folke/flash.nvim",
            event = { "CursorHold", "CursorHoldI" },
            -- stylua: ignore
            keys = {
                { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end },
                { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end },
            },
        },

        -- startup time
        {
            "dstein64/vim-startuptime",
            cmd = "StartupTime",
            init = function()
                vim.g.startuptime_tries = 10
            end,
        },
    },
})

require("plugins.keymap")
