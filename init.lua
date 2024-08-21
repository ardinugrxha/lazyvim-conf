-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("focus").setup({
  enable = true, -- Enable module
  commands = true, -- Create Focus commands
  autoresize = {
    enable = true, -- Enable or disable auto-resizing of splits
    width = 123, -- Default width for vertical splits
    height = 69, -- Default height for horizontal splits
    minwidth = 25, -- Minimum width for vertical splits
    minheight = 0, -- Minimum height for horizontal splits
    maxwidth = 200, -- Maximum width for vertical splits
    maxheight = 80,
  },
  split = {
    bufnew = false, -- Create blank buffer for new split windows
    tmux = false, -- Create tmux splits instead of neovim splits
  },
  ui = {
    number = false, -- Display line numbers in the focussed window only
    relativenumber = false, -- Display relative line numbers in the focussed window only
    hybridnumber = false, -- Display hybrid line numbers in the focussed window only
    absolutenumber_unfocussed = false, -- Preserve absolute numbers in the unfocussed windows

    cursorline = true, -- Display a cursorline in the focussed window only
    cursorcolumn = false, -- Display cursorcolumn in the focussed window only
    colorcolumn = {
      enable = false, -- Display colorcolumn in the foccused window only
      list = "+1", -- Set the comma-saperated list for the colorcolumn
    },
    signcolumn = true, -- Display signcolumn in the focussed window only
    winhighlight = false, -- Auto highlighting for focussed/unfocussed windows
  },
})
--
require("edgy").setup()
require("outline").setup()

require("transparent").clear_prefix("edgy")
require("transparent").clear_prefix("NeoTree")
require("transparent").clear_prefix("trouble")
require("transparent").clear_prefix("treesitter-context")

require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
    }),
    require("neotest-jest")({
      jestCommand = "npm test --",
      jestConfigFile = "custom.jest.config.ts",
      env = { CI = true },
      cwd = function()
        return vim.fn.getcwd()
      end,
    }),
  },
})

local ayu_dark_lua_line = require("lualine.themes.ayu_mirage")
ayu_dark_lua_line.normal.c.bg = "None"

require("lualine").setup({
  options = { theme = ayu_dark_lua_line },
})
vim.opt.relativenumber = false
vim.lsp.inlay_hint.enable(true)

local ignore_filetypes = { "oil", "edgy", "neo-tree", "Outline", "trouble" }

local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  callback = function(_)
    if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
      vim.b.focus_disable = true
    else
      vim.b.focus_disable = false
    end
  end,
  desc = "Disable focus autoresize for FileType",
})

local bufnr = vim.api.nvim_get_current_buf() -- Get the current buffer number
local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
print("Current filetype: " .. filetype)
