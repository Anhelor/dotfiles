local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>ls", "<cmd>Lazy sync<CR>", opts)
vim.api.nvim_set_keymap("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", opts)
vim.api.nvim_set_keymap("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>bp", "<cmd>BufferLinePick<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", opts)
