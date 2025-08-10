local delve = function(config)
  local delve_path = vim.fn.exepath "dlv"
  if delve_path == "" then
    delve_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/bin/dlv")
    if delve_path == "" then
      vim.notify("delve debugger not found. Install via Mason", vim.log.levels.WARN)
      require("mason-nvim-dap").default_setup(config)
      return
    end
  end

  config.adapters = {
    type = "server",
    port = "${port}",
    executable = {
      command = delve_path,
      args = { "dap", "-l", "127.0.0.1:${port}" },
    },
  }

  config.configurations = {
    { type = "delve", name = "Debug", request = "launch", program = "${file}" },
    { type = "delve", name = "Debug test", request = "launch", mode = "test", program = "${file}" },
    {
      type = "delve",
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
    },
  }

  require("mason-nvim-dap").default_setup(config)
end

return {
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    cmd = {
      "DapContinue",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
      "DapToggleBreakpoint",
      "DapTerminate",
      "DapRestartFrame",
      "DapRunToCursor",
      "DapDisconnect",
      "DapPause",
      "DapClose",
    },
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Debug Continue" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dt", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dR", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>dU", function() require("dapui").toggle() end, desc = "Toggle UI" },
    },
    dependencies = {
      { "rcarriga/nvim-dap-ui", dependencies = "nvim-neotest/nvim-nio" },
      "theHamsta/nvim-dap-virtual-text",
      "LiadOz/nvim-dap-repl-highlights",
      {
        "jay-babu/mason-nvim-dap.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          automatic_setup = true,
          handlers = {
            function(config) require("mason-nvim-dap").default_setup(config) end,
            python = function(config)
              config.adapters = {
                type = "executable",
                command = "/usr/bin/python3",
                args = { "-m", "debugpy.adapter" },
              }
              require("mason-nvim-dap").default_setup(config)
            end,
            coreclr = function(config)
              local platform = require("utils").platform
              local dotnet_paths = platform.get_dotnet_paths()
              if not dotnet_paths.netcoredbg then
                vim.notify("netcoredbg not found. Install via :MasonInstall coreclr", vim.log.levels.WARN)
                require("mason-nvim-dap").default_setup(config)
                return
              end
              config.adapters = {
                type = "executable",
                command = dotnet_paths.netcoredbg,
                args = { "--interpreter=vscode" },
              }
              config.configurations = {
                {
                  type = "coreclr",
                  name = "Launch .NET Core (Auto Pick DLL)",
                  request = "launch",
                  program = function()
                    local choices = platform.auto_discover_dotnet_dlls()
                    if #choices == 0 then
                      vim.notify("No .NET DLLs found", vim.log.levels.ERROR)
                      return ""
                    end
                    return coroutine.create(function(coro)
                      vim.ui.select(
                        choices,
                        { prompt = "Select DLL to debug:" },
                        function(choice) coroutine.resume(coro, choice) end
                      )
                    end)
                  end,
                },
                {
                  type = "coreclr",
                  name = "Attach to Process",
                  request = "attach",
                  processId = require("dap.utils").pick_process,
                },
              }
              require("mason-nvim-dap").default_setup(config)
            end,
            delve = delve,
          },
          ensure_installed = { "codelldb", "coreclr", "cppdbg", "python", "delve", "chrome", "firefox", "js" },
        },
      },
      {
        "nvim-telescope/telescope-dap.nvim",
        keys = {
          {
            "<leader>tB",
            function()
              require("telescope").load_extension "dap"
              require("telescope").extensions.dap.list_breakpoints()
            end,
            desc = "[T]elescope [B]reakpoints",
          },
        },
      },
    },
    config = function(_, opts)
      local icons = require "config.icons"
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
      for name, sign in pairs(icons.dap) do
        local s = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = s[1], texthl = s[2] or "DiagnosticInfo", linehl = s[3], numhl = s[3] }
        )
      end
      require("nvim-dap-virtual-text").setup { commented = true }
      local dap, dapui = require "dap", require "dapui"
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end,
  },
}
