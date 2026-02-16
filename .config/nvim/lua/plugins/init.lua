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
    defaults = { lazy = true },

    spec = {
        -- colorscheme
        {
            "catppuccin/nvim",
            name = "catppuccin",
            event = "VimEnter",
            priority = 1000,
            config = function()
                require("catppuccin").setup({ flavour = "mocha" })
                vim.cmd.colorscheme("catppuccin")
            end,
        },

        -- lualine
        {
            "nvim-lualine/lualine.nvim",
            event = "VeryLazy",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            config = function()
                require("plugins.lualine").config()
            end,
        },

        -- bufferline
        {
            "akinsho/bufferline.nvim",
            event = "VeryLazy",
            keys = {
                { "<Tab>", "<cmd>BufferLineCycleNext<CR>", mode = "n" },
                { "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", mode = "n" },
                { "<leader>bp", "<cmd>BufferLinePick<CR>", mode = "n" },
                { "<leader>bc", "<cmd>BufferLinePickClose<CR>", mode = "n" },
            },
            dependencies = { "nvim-tree/nvim-web-devicons" },
            config = function()
                require("bufferline").setup({
                    highlights = require("catppuccin.special.bufferline").get_theme(),
                })
            end,
        },

        -- treesitter
        {
            "nvim-treesitter/nvim-treesitter",
            branch = "main",
            event = { "BufReadPre", "BufNewFile" },
            build = function()
                require("plugins.treesitter").build()
            end,
            config = function()
                require("plugins.treesitter").config()
            end,
            dependencies = {
                { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
                { "hiphish/rainbow-delimiters.nvim" },
            },
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
            event = { "BufReadPre", "BufNewFile" },
            config = function()
                require("plugins.lsp").config()
            end,
        },

        -- telescope
        {
            "nvim-telescope/telescope.nvim",
            cmd = "Telescope",
            keys = {
                { "<leader>ff", "<cmd>Telescope find_files<CR>", mode = "n" },
                { "<leader>fg", "<cmd>Telescope live_grep<CR>", mode = "n" },
                { "<leader>fd", "<cmd>Telescope diagnostics<CR>", mode = "n" },
            },
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = { defaults = { layout_config = { horizontal = { preview_width = 0.618 } } } },
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
            config = function()
                require("plugins.cmp").config()
            end,
        },

        -- comment
        {
            "numToStr/Comment.nvim",
            keys = {
                { "gc", mode = { "n", "v" } },
                { "gcc", mode = "n" },
                { "gb", mode = { "n", "v" } },
                { "gbc", mode = "n" },
            },
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
            keys = {
                { "<C-u>", mode = "n" },
                { "<C-d>", mode = "n" },
                { "<C-b>", mode = "n" },
                { "<C-f>", mode = "n" },
            },
            opts = {},
        },

        -- accelerated-jk
        {
            "rainbowhxch/accelerated-jk.nvim",
            keys = {
                { "j", "<Plug>(accelerated_jk_gj)", mode = "n" },
                { "k", "<Plug>(accelerated_jk_gk)", mode = "n" },
            },
        },

        -- format code
        {
            "sbdchd/neoformat",
            cmd = "Neoformat",
            keys = {
                { "<leader>fc", "<cmd>Neoformat<CR>", mode = "n" },
                { "<leader>fc", ":'<,'>Neoformat<CR>", mode = "v" },
            },
            init = function()
                vim.g.shfmt_opt = "-s"
            end,
        },

        -- easymotion-like
        {
            "folke/flash.nvim",
            keys = {
                {
                    "s",
                    function()
                        require("flash").jump()
                    end,
                    mode = { "n", "x", "o" },
                },
                {
                    "S",
                    function()
                        require("flash").treesitter()
                    end,
                    mode = { "n", "x", "o" },
                },
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

    performance = {
        rtp = {
            disabled_plugins = {
                "editorconfig",
                "gzip",
                "man",
                "matchit",
                "matchparen",
                "netrw",
                "netrwPlugin",
                "rplugin",
                "shada",
                "spellfile",
                "tar",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zip",
                "zipPlugin",
            },
        },
    },
})
