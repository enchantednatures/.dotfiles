return {
  {
    "nvim-neotest/neotest",
    lazy = true,
    ft = { "python", "go", "rust", "cpp", "cs" },
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    dependencies = {
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-vim-test",
      "Issafalcon/neotest-dotnet",
      "alfaix/neotest-gtest",
      { "fredrikaverpil/neotest-golang", version = "*", dependencies = { "leoluz/nvim-dap-go" } },
    },
    keys = {
      {
        "<leader>TF",
        "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
        desc = "Debug File",
      },
      {
        "<leader>TL",
        "<cmd>lua require('neotest').run.run_last({strategy = 'dap'})<cr>",
        desc = "Debug Last",
      },
      {
        "<leader>Ta",
        "<cmd>lua require('neotest').run.attach()<cr>",
        desc = "Attach",
      },
      {
        "<leader>Tf",
        "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
        desc = "File",
      },
      {
        "<leader>Tl",
        "<cmd>lua require('neotest').run.run_last()<cr>",
        desc = "Last",
      },
      {
        "<leader>Tn",
        "<cmd>lua require('neotest').run.run()<cr>",
        desc = "Nearest",
      },
      {
        "<leader>TN",
        "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
        desc = "Debug Nearest",
      },
      {
        "<leader>TO",
        "<cmd>lua require('neotest').output.open({ enter = true })<cr>",
        desc = "Output",
      },
      {
        "<leader>Ts",
        "<cmd>lua require('neotest').run.stop()<cr>",
        desc = "Stop",
      },
      {
        "<leader>TS",
        "<cmd>lua require('neotest').summary.toggle()<cr>",
        desc = "Summary",
      },
    },

    config = function()
      local opts = {
        adapters = {
          require "neotest-python" {
            dap = { justMyCode = false },
            runner = "unittest",
          },
          require "neotest-plenary",
          require "neotest-vim-test" {
            ignore_file_types = { "python", "vim", "lua" },
          },
          require "rustaceanvim.neotest",
          require "neotest-golang" {},
          require "neotest-dotnet" {
            dap = {
              adapter_name = "coreclr",
              enabled = true,
            },
            discovery_root = "solution",
            discovery_recursive = true,
            output_live = true,
          },
        },
        -- overseer.nvim
        consumers = {
          overseer = require "neotest.consumers.overseer",
        },
        overseer = {
          enabled = true,
          force_default = true,
        },
        strategies = {},
      }
      require("neotest").setup(opts)
    end,
  },
  {
    "stevearc/overseer.nvim",
    lazy = true,
    event = { "VeryLazy" },
    cmd = { "OverseerRunCmd", "OverseerToggle" },
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
        templates = { "builtin", "user.dotnet-test", "user.docker-compose", "user.go", "user.go-build", "user.rust" }, -- //"user.neotest"
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
