local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>ls", "<cmd>Lazy sync<CR>", opts)

vim.api.nvim_set_keymap("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", opts)
vim.api.nvim_set_keymap("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", opts)

vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", opts)
vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", opts)

vim.api.nvim_set_keymap("n", "<leader>fc", "<cmd>Neoformat<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>Neoformat black<CR>", opts)

vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
