local M = {}

local function has_words_before()
    local unpack_fn = unpack or table.unpack
    local line, col = unpack_fn(vim.api.nvim_win_get_cursor(0))
    if col == 0 then
        return false
    end
    local text = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1] or ""
    return text:sub(col, col):match("%s") == nil
end

function M.config()
    local luasnip = require("luasnip")
    local cmp = require("cmp")

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = {
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-e>"] = cmp.mapping.close(),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        },
        formatting = {
            format = require("lspkind").cmp_format({}),
        },
        sources = {
            { name = "nvim_lsp" },
            { name = "nvim_lsp_signature_help" },
            { name = "nvim_lua" },
            { name = "luasnip" },
            { name = "path" },
            { name = "dictionary", keyword_length = 2, max_item_count = 10 },
            { name = "buffer" },
        },
    })
end

return M
