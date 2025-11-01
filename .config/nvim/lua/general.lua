-- autocmds
local augroup = vim.api.nvim_create_augroup("UserDefinedAutocmds", {})
-- go to last position
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup,
    pattern = "*",
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]],
})
-- trim whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    pattern = "*",
    command = [[silent! lua vim.highlight.on_yank({timeout=200})]],
})

-- variables
-- leader keys
vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[,]]

-- providers
vim.g.python3_host_prog = "/usr/bin/python"
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- disable built-in plugins
vim.g.did_install_default_menus = 1
vim.g.did_install_syntax_menu = 1
vim.g.loaded_syntax_completion = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.netrw_liststyle = 3
vim.g.loaded_2html_plugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_sql_completion = 1
vim.g.editorconfig = 1
vim.g.loaded_remote_plugins = 1

-- options
vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.cmdheight = 1
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 4
vim.opt.signcolumn = "yes"
vim.opt.ignorecase = true
vim.opt.linebreak = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.clipboard = "unnamedplus"
vim.opt.diffopt:append("algorithm:patience")

if vim.env.SSH_TTY ~= nil then
    local function reg_paste_fn(_)
        return function(_)
            local content = vim.fn.getreg('"')
            return vim.split(content, "\n")
        end
    end
    vim.g.clipboard = {
        name = "OSC 52",
        copy = {
            ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
            ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
        },
        paste = {
            ["+"] = reg_paste_fn("+"),
            ["*"] = reg_paste_fn("*"),
        },
    }
end

-- mappings
vim.keymap.set("n", "0", "^", { noremap = true, silent = true })
vim.keymap.set("n", "yp", "<cmd>%y<CR>", { noremap = true, silent = true })

vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

vim.keymap.set("n", "<A-w>", "<cmd>w<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-q>", "<cmd>q<CR>", { noremap = true, silent = true })
vim.keymap.set({ "i", "v", "c", "t" }, "<A-;>", "<Esc>", { noremap = true, silent = true })

vim.keymap.set("n", "<A-n>", "<cmd>nohl<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-i>", function()
    vim.o.ignorecase = not vim.o.ignorecase
    vim.notify("ignorecase: " .. tostring(vim.o.ignorecase))
end, { noremap = true, silent = true })

for _, d in ipairs({ "h", "j", "k", "l" }) do
    vim.keymap.set("n", "<C-" .. d .. ">", "<C-w>" .. d, { noremap = true })
end
