return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>ue",
      function()
        require("edgy").toggle()
      end,
      desc = "Edgy Toggle",
    },
    -- stylua: ignore
    { "<leader>uE", function() require("edgy").select() end, desc = "Edgy Select Window" },
  },
  opts = function()
    local opts = {
      bottom = {
        {
          ft = "noice",
          size = { height = 0.4 },
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
        "Trouble",
        { ft = "qf", title = "QuickFix" },
        {
          ft = "help",
          size = { height = 20, width = 40 },
          -- don't open help files in edgy that we're editing
          filter = function(buf)
            return vim.bo[buf].buftype == "help"
          end,
        },
        {
          title = "DAP UI REPL",
          ft = "dap-repl",
          size = { height = 15 },
          filter = function(buf)
            return vim.bo[buf].filetype == "dap-repl"
          end,
          pinned = true,
          open = "DapuiOpenRepl", -- Adjust according to your setup if needed
        },
        {
          title = "DAP UI Console",
          ft = "dapui_console", -- DAP REPL is usually used as the console as well
          size = { height = 15 },
          filter = function(buf)
            return vim.bo[buf].filetype == "dapui_console"
          end,
          pinned = true,
        },
        -- { title = "Spectre", ft = "spectre_panel", size = { height = 0.4 } },
        { title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
      },
      left = {
        { title = "Neotest Summary", ft = "neotest-summary" },
        { title = "Grug Far", ft = "grug-far", size = { width = 0.4 } },
        -- "neo-tree",
      },
      right = {
        {
          title = "DAP UI Scopes",
          ft = "dapui_scopes",
          size = { width = 60, height = 30 }, -- Fixed width for DAP UI Scopes
          filter = function(buf)
            return vim.bo[buf].filetype == "dapui_scopes"
          end,
          pinned = true,
          open = "DapuiOpenScopes",
        },
        {
          title = "DAP UI Breakpoints",
          ft = "dapui_breakpoints",
          size = { width = 60 }, -- Fixed width for DAP UI Breakpoints
          filter = function(buf)
            return vim.bo[buf].filetype == "dapui_breakpoints"
          end,
          pinned = true,
          open = "DapuiOpenBreakpoints",
        },
        {
          title = "DAP UI Stacks",
          ft = "dapui_stacks",
          size = { width = 60 }, -- Fixed width for DAP UI Stacks
          filter = function(buf)
            return vim.bo[buf].filetype == "dapui_stacks"
          end,
          pinned = true,
          open = "DapuiOpenStacks",
        },
        {
          title = "DAP UI Watches",
          ft = "dapui_watches",
          size = { width = 60 }, -- Fixed width for DAP UI Watches
          filter = function(buf)
            return vim.bo[buf].filetype == "dapui_watches"
          end,
          pinned = true,
          open = "DapuiOpenWatches",
        },
      },
      keys = {
        -- increase width
        ["<c-Right>"] = function(win)
          win:resize("width", 2)
        end,
        -- decrease width
        ["<c-Left>"] = function(win)
          win:resize("width", -2)
        end,
        -- increase height
        ["<c-Up>"] = function(win)
          win:resize("height", 2)
        end,
        -- decrease height
        ["<c-Down>"] = function(win)
          win:resize("height", -2)
        end,
      },
    }
    return opts
  end,
}
