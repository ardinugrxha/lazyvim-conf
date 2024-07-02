-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.api.nvim_set_keymap("n", "d", '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "d", '"_d', { noremap = true, silent = true })
-- Map <leader>p in visual mode to "_dP
vim.api.nvim_set_keymap("x", "<leader>p", '"_dP', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<S-s>", "<S-$>", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-a>", "<S-^>", { noremap = true })
-- -- Map Shift + $ to Shift + s
-- vim.api.nvim_set_keymap('n', '<S-$>', '<S-s>', { noremap = true })
-- -- Map Shift + ^ to Shift + a
-- vim.api.nvim_set_keymap('n', '<S-^>', '<S-a>', { noremap = true })

vim.api.nvim_set_keymap("n", "d", '"_d', { noremap = true, silent = true })

-- -- Map s to w
-- vim.api.nvim_set_keymap('n', 's', 'w', { noremap = true, silent = true })

-- -- Map a to b
-- vim.api.nvim_set_keymap('n', 'a', 'b', { noremap = true, silent = true })

vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>")
-- vim.opt.mouse = ""

vim.keymap.set(
  "n",
  "<leader>f/",
  ':lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>',
  { noremap = true, desc = "Find word current buffer" }
)

vim.keymap.set(
  "n",
  "<leader>fw",
  ':lua require("telescope.builtin").live_grep()<CR>',
  { noremap = true, desc = "Find words" }
)

vim.keymap.set("n", "<space>r", ':lua require("dbee").toggle()<CR>', { noremap = true, desc = "Open DBE UI" })

-- Check if "dbee" is toggled on
-- Execute SQL query

-- vim.keymap.set('n', '<C-CR>', ':<CMD> lua require("dbee").execute(vim.api.nvim_get_current_line())<CR>')
-- Set NeoTree position to float

vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle Spectre",
})
vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = "Search current word",
})
vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = "Search current word",
})
vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search on current file",
})
