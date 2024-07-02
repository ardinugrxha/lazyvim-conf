local js_based_languages = {
    "typescript",
    "javascript",
    "typescriptreact",
    "javascriptreact",
    "vue",
}
return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require "dap"
            require("nvim-dap-virtual-text").setup()

            local Config = require("lazyvim.config")
            vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
            for name, sign in pairs(Config.icons.dap) do
                sign = type(sign) == "table" and sign or { sign }
                vim.fn.sign_define(
                    "Dap" .. name,
                    { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
                )
            end
            dap.adapters.lldb = {
                type = "executable",
                command = "/usr/local/bin/lldb-vscode", -- adjust as needed, must be absolute path
                name = "lldb",
            }
            dap.configurations.cpp = {
                {
                    name = "Launch",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                    console = "integratedTerminal",

                    -- 💀
                    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
                    --
                    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
                    --
                    -- Otherwise you might get the following error:
                    --
                    --    Error on launch: Failed to attach to the target process
                    --
                    -- But you should be aware of the implications:
                    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
                    -- runInTerminal = false,
                },
                {
                    name = "launch.json configs",
                    type = "",
                    request = "launch",
                },
            }
            dap.configurations.go = {
                {
                    type = "delve",
                    name = "Debug (Remote binary)",
                    request = "launch",
                    mode = "exec",
                    hostName = "127.0.0.1",
                    port = "38697",
                    console = "integratedTerminal",
                    program = function()
                        local argument_string = vim.fn.input "Path to binary: "
                        vim.notify("\n Debugging binary: " .. argument_string)
                        return vim.fn.split(argument_string, " ", true)[1]
                    end,
                },
                {
                    name = "launch.json configs",
                    type = "",
                    request = "launch",
                },
            }
            dap.configurations.rust = {
                {
                    name = "Launch file",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                },
            }
            for _, language in ipairs(js_based_languages) do
                dap.configurations[language] = {
                    -- Debug single nodejs files
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Launch file",
                        program = "${file}",
                        cwd = vim.fn.getcwd(),
                        sourceMaps = true,
                    },
                    -- Debug nodejs processes (make sure to add --inspect when you run the process)
                    {
                        type = "pwa-node",
                        request = "attach",
                        name = "Attach",
                        processId = require("dap.utils").pick_process,
                        cwd = vim.fn.getcwd(),
                        sourceMaps = true,
                    },
                    -- Debug web applications (client side)
                    {
                        type = "pwa-chrome",
                        request = "launch",
                        name = "Launch & Debug Chrome",
                        url = function()
                            local co = coroutine.running()
                            return coroutine.create(function()
                                vim.ui.input({
                                    prompt = "Enter URL: ",
                                    default = "http://localhost:3000",
                                }, function(url)
                                    if url == nil or url == "" then
                                        return
                                    else
                                        coroutine.resume(co, url)
                                    end
                                end)
                            end)
                        end,
                        webRoot = vim.fn.getcwd(),
                        protocol = "inspector",
                        sourceMaps = true,
                        userDataDir = false,
                    },
                    -- Divider for the launch.json derived configs
                    {
                        name = "----- ↓ launch.json configs ↓ -----",
                        type = "",
                        request = "launch",
                    },
                }
            end
        end,
        keys = {
            {
                "<leader>dO",
                function()
                    require("dap").step_out()
                end,
                desc = "Step Out",
            },
            {
                "<leader>do",
                function()
                    require("dap").step_over()
                end,
                desc = "Step Over",
            },
            {
                "<leader>da",
                function()
                    if vim.fn.filereadable(".vscode/launch.json") then
                        local dap_vscode = require("dap.ext.vscode")
                        dap_vscode.load_launchjs(nil, {
                            ["pwa-node"] = js_based_languages,
                            ["chrome"] = js_based_languages,
                            ["pwa-chrome"] = js_based_languages,
                        })
                    end
                    require("dap").continue()
                end,
                desc = "Run with Args",
            },
        },
        dependencies = {
            -- Install the vscode-js-debug adapter
            {
                "microsoft/vscode-js-debug",
                -- After install, build it and rename the dist directory to out
                build =
                "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
                version = "1.*",
            },
            {
                "rcarriga/nvim-dap-ui",
                event = "VeryLazy",
                opts = { floating = { border = "rounded" } },
                dependencies = { "mxsdev/nvim-dap-vscode-js" },
                config = function()
                    local dapui = require("dapui")
                    dapui.setup {
                        floating = {
                            border = "single",
                            mappings = {
                                close = { "q", "<Esc>" },
                            },
                        },
                        layouts = {
                            {
                                elements = {
                                    {
                                        id = "scopes",
                                        size = 0.25,
                                    },
                                    {
                                        id = "breakpoints",
                                        size = 0.25,
                                    },
                                    {
                                        id = "stacks",
                                        size = 0.25,
                                    },
                                    {
                                        id = "watches",
                                        size = 0.25,
                                    },
                                    {
                                        id = "console",
                                        size = 10,
                                    },
                                    {
                                        id = "repl",
                                        size = 10,
                                    },

                                },
                                position = "right",
                                size = 25,
                            },

                        },
                        expand_lines = vim.fn.has "nvim-0.7" == 1,
                    }
                end,
            },
            {
                "mxsdev/nvim-dap-vscode-js",
                config = function()
                    ---@diagnostic disable-next-line: missing-fields
                    require("dap-vscode-js").setup({
                        -- Path of node executable. Defaults to $NODE_PATH, and then "node"
                        -- node_path = "node",
                        -- Path to vscode-js-debug installation.
                        debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
                        -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
                        -- debugger_cmd = { "js-debug-adapter" },
                        -- which adapters to register in nvim-dap
                        adapters = {
                            "chrome",
                            "pwa-node",
                            "pwa-chrome",
                            "pwa-msedge",
                            "pwa-extensionHost",
                            "node-terminal",
                        },
                        -- Path for file logging
                        -- log_file_path = "(stdpath cache)/dap_vscode_js.log",
                        -- Logging level for output to file. Set to false to disable logging.
                        -- log_file_level = false,
                        -- Logging level for output to console. Set to false to disable console output.
                        -- log_console_level = vim.log.levels.ERROR,
                    })
                end,
            },
            {
                "Joakker/lua-json5",
                build = "bash ./install.sh",
            },
        },
    },
}
