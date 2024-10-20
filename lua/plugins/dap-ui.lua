return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "nvim-neotest/nvim-nio" },
  -- stylua: ignore
  keys = {
    { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
  },
  opts = {},
  config = function(_, opts)
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup(opts)

    local function close_neo_tree()
      local neotree_status_ok, neotree = pcall(require, "neo-tree")
      if neotree_status_ok then
        -- Assuming Neo Tree is in the left or right position
        vim.cmd("Neotree close")
      end
    end

    -- Automatically close Neo Tree when the DAP UI is opened
    dap.listeners.after.event_initialized["close_neo_tree"] = function()
      close_neo_tree()
      dapui.open() -- Optional: Open the DAP UI after closing Neo Tree
    end

    -- Automatically close Neo Tree when DAP session terminates or exits
    dap.listeners.before.event_terminated["close_neo_tree"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["close_neo_tree"] = function()
      dapui.close()
    end

    -- Reopen Neo Tree after DAP UI closes (when debugging ends)
    dap.listeners.after.event_terminated["reopen_neo_tree"] = function()
      vim.cmd("Neotree show")
    end
    dap.listeners.after.event_exited["reopen_neo_tree"] = function()
      vim.cmd("Neotree show")
    end
  end,
}
