local delve = function(config)
  local delve_path = vim.fn.exepath "dlv"
  if delve_path == "" then
    -- Try to find it in Mason's bin directory
    delve_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/bin/dlv")
    if delve_path == "" then
      vim.notify("delve debugger not found. Make sure it's installed via mason", vim.log.levels.WARN)
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
    {
      type = "delve",
      name = "Debug",
      request = "launch",
      program = "${file}",
    },
    {
      type = "delve",
      name = "Debug test", -- configuration for debugging test files
      request = "launch",
      mode = "test",
      program = "${file}",
    },
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
    event = { "VeryLazy" },
    dependencies = {
      { "rcarriga/nvim-dap-ui", dependencies = "nvim-neotest/nvim-nio" },
      "theHamsta/nvim-dap-virtual-text",
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

      "LiadOz/nvim-dap-repl-highlights",
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          automatic_setup = true,
          handlers = {
            function(config)
              -- all sources with no handler get passed here

              -- Keep original functionality
              require("mason-nvim-dap").default_setup(config)
            end,
            python = function(config)
              config.adapters = {
                type = "executable",
                command = "/usr/bin/python3",
                args = {
                  "-m",
                  "debugpy.adapter",
                },
              }
              require("mason-nvim-dap").default_setup(config) -- don't forget this!
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
                      vim.notify("No .NET DLLs found in ./bin/Debug/**/", vim.log.levels.ERROR)
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
          ensure_installed = {
            "codelldb",
            "coreclr",
            "cppdbg",
            "python",
            "delve",
            "chrome",
            "firefox",
            -- "javadbg",
            -- "javatest",
            "js",
          },
        },
      },
    },
    -- stylua: ignore
    keys = {
      {
        "<leader>dR",
        function() require("dap").run_to_cursor() end,
        desc = "Run to Cursor",
      },
      {
        "<leader>dE",
        function() require("dapui").eval(vim.fn.input "[Expression] > ") end,
        desc = "Evaluate Input",
      },
      {
        "<leader>dC",
        function() require("dap").set_breakpoint(vim.fn.input "[Condition] > ") end,
        desc = "Conditional Breakpoint",
      },
      {
        "<leader>dU",
        function() require("dapui").toggle() end,
        desc = "Toggle UI",
      },
      {
        "<leader>db",
        function() require("dap").step_back() end,
        desc = "Step Back",
      },
      {
        "<F5>",
        function() require("dap").continue() end,
        desc = "Continue",
      },
      {
        "<leader>dc",
        function() require("dap").continue() end,
        desc = "Continue",
      },
      {
        "<leader>dd",
        function() require("dap").disconnect() end,
        desc = "Disconnect",
      },
      {
        "<leader>de",
        function() require("dapui").eval() end,
        mode = {
          "n", "v" },
        desc = "Evaluate",
      },
      {
        "<leader>dg",
        function() require("dap").session() end,
        desc = "Get Session",
      },
      {
        "<leader>dh",
        function() require("dap.ui.widgets").hover() end,
        desc = "Hover Variables",
      },
      {
        "<leader>dS",
        function() require("dap.ui.widgets").scopes() end,
        desc = "Scopes",
      },
      {
        "<leader>di",
        function() require("dap").step_into() end,
        desc = "Step Into",
      },
      {
        "<leader>do",
        function() require("dap").step_over() end,
        desc = "Step Over",
      },
      {
        "<leader>dl",
        function() require("dap").run_last() end,
        desc = "Run Last"
      },
      {
        "<leader>dp",
        function() require("dap").pause.toggle() end,
        desc = "Pause",
      },
      {
        "<leader>dq",
        function() require("dap").close() end,
        desc = "Quit",
      },
      {
        "<leader>dr",
        function() require("dap").repl.toggle() end,
        desc = "Toggle REPL",
      },
      {
        "<leader>ds",
        function() require("dap").continue() end,
        desc = "Start",
      },
      {
        "<leader>dt",
        function() require("dap").toggle_breakpoint() end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dx",
        function() require("dap").terminate() end,
        desc = "Terminate",
      },
      {
        "<leader>du",
        function() require("dap").step_out() end,
        desc = "Step Out",
      },
    },
    config = function(plugin, opts)
      local icons = require "config.icons"
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

      require("nvim-dap-virtual-text").setup {
        commented = true,
      }

      local dap, dapui = require "dap", require "dapui"
      dapui.setup(opts)

      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end,
  },
}
