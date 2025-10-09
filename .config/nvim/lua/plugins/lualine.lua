local opts = {
    options = {
        theme = "catppuccin",
        section_separators = "",
        component_separators = "",
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "filename", "filesize" },
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

return function()
    require("lualine").setup(opts)
end
