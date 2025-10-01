return function()
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
            vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
            local opts = { buffer = ev.buf }
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        end,
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
    vim.lsp.config["pyright"] = {
        capabilities = capabilities,
        settings = {
            python = {
                analysis = {
                    diagnosticMode = "off",
                    typeCheckingMode = "off",
                },
            },
        },
    }
    vim.lsp.enable("pyright")
    vim.lsp.config["lua_ls"] = {
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                    disable = { "different-requires" },
                },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    },
                    maxPreload = 100000,
                    preloadFileSize = 10000,
                },
                format = { enable = false },
                telemetry = { enable = false },
                semantic = { enable = false },
            },
        },
    }
    vim.lsp.enable("lua_ls")
    vim.lsp.config["clangd"] = {
        capabilities = capabilities,
        single_file_support = true,
        cmd = { "clangd", "-j=6", "--pch-storage=memory", "--clang-tidy" },
    }
    vim.lsp.enable("clangd")
end
