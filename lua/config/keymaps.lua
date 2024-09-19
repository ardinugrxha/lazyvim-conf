-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.api.nvim_set_keymap("n", "d", '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "d", '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<leader>p", '"_dP', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-s>", "<S-$>", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-a>", "<S-^>", { noremap = true })
vim.api.nvim_set_keymap("n", "d", '"_d', { noremap = true, silent = true })
