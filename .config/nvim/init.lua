vim.g.mapleader = ' ' -- Set Leader
vim.g.maplocalleader = ','
-- Disable netrw for using NvimTree

vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

local profile = "spiccy"

-- Require configs
require(profile .. ".options")
require(profile .. ".plugins")
require(profile .. ".treesitter")
require(profile .. ".lsp")
require(profile .. ".complete")
require(profile .. ".telescope")

-- Keymaps
vim.keymap.set("n", "<A-o>", "<cmd>NvimTreeToggle<cr>", { desc = "NvimTree Open/Close" })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
