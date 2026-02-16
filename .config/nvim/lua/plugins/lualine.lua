local M = {}

local opts = {
    options = {
        theme = "catppuccin",
        section_separators = "",
        component_separators = "",
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { { "filename", path = 1 }, "filesize" },
        lualine_x = {
            { "diagnostics", sources = { "nvim_diagnostic" } },
            "encoding",
            "fileformat",
            "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
}

function M.config()
    require("lualine").setup(opts)
end

return M
