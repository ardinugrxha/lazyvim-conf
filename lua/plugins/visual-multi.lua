return {
  -- Other plugin entries...

  -- Add this entry to install vim-visual-multi
  {
    "mg979/vim-visual-multi",
    branch = "master",
  },
  {
    "vscode-neovim/vscode-multi-cursor.nvim",
    event = "VeryLazy",
    cond = not not vim.g.vscode,
    opts = {},
  },
}
