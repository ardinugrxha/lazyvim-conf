-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.api.nvim_set_keymap("n", "d", '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "d", '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<leader>p", '"_dP', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-s>", "<S-$>", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-a>", "<S-^>", { noremap = true })
vim.api.nvim_set_keymap("n", "d", '"_d', { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "mciw*<Cmd>nohl<CR>", { remap = true })

local api = vim.api
local function toggle_oil_float()
  for _, win in pairs(api.nvim_list_wins()) do
    local buf = api.nvim_win_get_buf(win)
    if api.nvim_buf_get_name(buf):match("^oil://") then
      api.nvim_win_close(win, true)
      return
    end
  end

  vim.cmd("Oil --float")
end

vim.keymap.set("n", "<leader>e", toggle_oil_float, { desc = "Toggle Oil float" })
