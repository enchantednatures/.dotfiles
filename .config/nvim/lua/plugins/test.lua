-- ============================================================================
-- Module: plugins/test.lua
-- Description: Testing framework (neotest) + task runner (overseer)
-- Dependencies: neotest, overseer.nvim
-- ============================================================================

return {
  {
    "nvim-neotest/neotest",
    lazy = true,
    ft = { "python", "go", "rust", "cpp", "cs" }, -- load only for these filetypes
    cmd = { "NeotestRun", "NeotestAttach", "NeotestSummary", "NeotestOutput" },
    keys = {
      {
        "<leader>TF",
        function() require("neotest").run.run { vim.fn.expand "%", strategy = "dap" } end,
        desc = "Debug File",
      },
      {
        "<leader>TL",
        function() require("neotest").run.run_last { strategy = "dap" } end,
        desc = "Debug Last",
      },
      { "<leader>Ta", function() require("neotest").run.attach() end, desc = "Attach" },
      { "<leader>Tf", function() require("neotest").run.run(vim.fn.expand "%") end, desc = "File" },
      { "<leader>Tl", function() require("neotest").run.run_last() end, desc = "Last" },
      { "<leader>Tn", function() require("neotest").run.run() end, desc = "Nearest" },
      {
        "<leader>TN",
        function() require("neotest").run.run { strategy = "dap" } end,
        desc = "Debug Nearest",
      },
      {
        "<leader>TO",
        function() require("neotest").output.open { enter = true } end,
        desc = "Output",
      },
      { "<leader>Ts", function() require("neotest").run.stop() end, desc = "Stop" },
      { "<leader>TS", function() require("neotest").summary.toggle() end, desc = "Summary" },
    },
    dependencies = {
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-vim-test",
      "Issafalcon/neotest-dotnet",
      "alfaix/neotest-gtest",
      {
        "fredrikaverpil/neotest-golang",
        version = "*",
        dependencies = { "leoluz/nvim-dap-go" },
      },
    },
    config = function()
      local adapters = {
        require("neotest-python") {
          dap = { justMyCode = false },
          runner = "unittest",
        },
        require("neotest-plenary"),
        require("neotest-vim-test") {
          ignore_file_types = { "python", "vim", "lua" },
        },
        require("rustaceanvim.neotest") {
          args = { "--archive-format", "auto" },
        },
          require "neotest-golang" {},
        require("neotest-dotnet") {
          dap = { adapter_name = "coreclr", enabled = true },
          discovery_root = "solution",
          discovery_recursive = true,
          output_live = true,
        },
      }
      
      require("neotest").setup {
        adapters = adapters,
        consumers = {
          overseer = require("neotest.consumers.overseer"),
        },
        overseer = {
          enabled = true,
          force_default = true,
        },
      }
    end,
  },
  {
    "stevearc/overseer.nvim",
    lazy = true,
    cmd = {
      "OverseerRunCmd",
      "OverseerToggle",
      "OverseerBuild",
      "OverseerOpen",
      "OverseerRun",
    },
    keys = {
      { "<leader>oR", "<cmd>OverseerRunCmd<cr>", desc = "Run Command" },
      { "<leader>oa", "<cmd>OverseerTaskAction<cr>", desc = "Task Action" },
      { "<leader>ob", "<cmd>OverseerBuild<cr>", desc = "Build" },
      { "<leader>oc", "<cmd>OverseerClose<cr>", desc = "Close" },
      { "<leader>od", "<cmd>OverseerDeleteBundle<cr>", desc = "Delete Bundle" },
      { "<leader>ol", "<cmd>OverseerLoadBundle<cr>", desc = "Load Bundle" },
      { "<leader>oo", "<cmd>OverseerOpen<cr>", desc = "Open" },
      { "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Quick Action" },
      { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run" },
      { "<leader>os", "<cmd>OverseerSaveBundle<cr>", desc = "Save Bundle" },
      { "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Toggle" },
    },
    config = function()
      require("overseer").setup {
        templates = {
          "builtin",
          "user.dotnet-test",
          "user.docker-compose",
          "user.go",
          "user.go-build",
          "user.rust",
        },
        component_aliases = {
          default_neotest = {
            "on_output_summarize",
            "on_exit_set_status",
            "on_complete_notify",
            "on_complete_dispose",
          },
        },
      }
    end,
  },
}
