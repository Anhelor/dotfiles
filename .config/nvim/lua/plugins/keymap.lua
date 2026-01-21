local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", opts)
vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePick<CR>", opts)
vim.keymap.set("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", opts)

vim.keymap.set("n", "j", "<Plug>(accelerated_jk_gj)", opts)
vim.keymap.set("n", "k", "<Plug>(accelerated_jk_gk)", opts)

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", opts)

vim.keymap.set("n", "<leader>fc", "<cmd>Neoformat<CR>", opts)
vim.keymap.set("v", "<leader>fc", ":'<,'>Neoformat<CR>", opts)

vim.keymap.set("n", "<leader>sh", "<cmd>LspClangdSwitchSourceHeader<CR>", opts)
