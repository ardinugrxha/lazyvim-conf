-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("focus").setup({
    enable = true,            -- Enable module
    commands = true,          -- Create Focus commands
    autoresize = {
        enable = true,        -- Enable or disable auto-resizing of splits
        width = 0,            -- Force width for the focused window
        height = 0,           -- Force height for the focused window
        minwidth = 20,        -- Force minimum width for the unfocused window
        minheight = 0,        -- Force minimum height for the unfocused window
        height_quickfix = 10, -- Set the height of quickfix panel
    },
    split = {
        bufnew = false, -- Create blank buffer for new split windows
        tmux = false,   -- Create tmux splits instead of neovim splits
    },
    ui = {
        number = false,                    -- Display line numbers in the focussed window only
        relativenumber = false,            -- Display relative line numbers in the focussed window only
        hybridnumber = false,              -- Display hybrid line numbers in the focussed window only
        absolutenumber_unfocussed = false, -- Preserve absolute numbers in the unfocussed windows

        cursorline = true,                 -- Display a cursorline in the focussed window only
        cursorcolumn = false,              -- Display cursorcolumn in the focussed window only
        colorcolumn = {
            enable = false,                -- Display colorcolumn in the foccused window only
            list = '+1',                   -- Set the comma-saperated list for the colorcolumn
        },
        signcolumn = true,                 -- Display signcolumn in the focussed window only
        winhighlight = false,              -- Auto highlighting for focussed/unfocussed windows
    }
})
require("neo-tree").setup({
    window = {
        position = "float"
    }
})
require('transparent').clear_prefix('NeoTree')

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
        })
    },
})

local ayu_dark_lua_line = require 'lualine.themes.ayu_mirage'
ayu_dark_lua_line.normal.c.bg = 'None'

require('lualine').setup {
    options = { theme = ayu_dark_lua_line },
}
vim.lsp.inlay_hint.enable(true)
