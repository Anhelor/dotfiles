local M = {}

local langs = {
    "bash",
    "c",
    "cmake",
    "comment",
    "cpp",
    "cuda",
    "lua",
    "json",
    "python",
    "vim",
    "vimdoc",
}

function M.build()
    require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
    })
    require("nvim-treesitter").install(langs):wait(300000)
end

function M.config()
    require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
    })

    require("nvim-treesitter").install(langs)

    require("nvim-treesitter-textobjects").setup({
        select = {
            lookahead = true,
            selection_modes = {
                ["@function.outer"] = "V",
                ["@class.outer"] = "V",
                ["@loop.outer"] = "V",
            },
        },
    })

    local select = require("nvim-treesitter-textobjects.select").select_textobject
    local map = function(lhs, capture)
        vim.keymap.set({ "o", "x" }, lhs, function()
            select(capture, "textobjects")
        end, { silent = true })
    end

    map("af", "@function.outer")
    map("if", "@function.inner")
    map("ac", "@class.outer")
    map("ic", "@class.inner")
    map("al", "@loop.outer")
    map("il", "@loop.inner")

    vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev)
            if vim.tbl_contains(langs, vim.bo[ev.buf].filetype) then
                vim.treesitter.start(ev.buf)
                vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
        end,
    })
end

return M
