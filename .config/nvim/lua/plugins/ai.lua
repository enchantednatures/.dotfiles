return {
  "olimorris/codecompanion.nvim",
  cmd = {
    "CodeCompanionChat",
    "CodeCompanionActions",
    "CodeCompanionCmd",
    "CodeCompanionChat",
  },
  keys = {

    {
      "<leader>aa",
      function() require("codecompanion").actions() end,
      desc = "Actions",
    },
    {
      "<leader>ac",
      function() require("codecompanion").chat() end,
      desc = "Start Chat",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "zbirenbaum/copilot.lua",
    "nvim-treesitter/nvim-treesitter",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown", "codecompanion" },
    },
  },
  opts = {
    adapters = {
      acp = {
        opencode = function() return require("codecompanion.adapters").extend("opencode", {}) end,
      },
    },
    strategies = {
      chat = {
        adapter = "opencode",
        model = "gpt-5-mini",
      },
      inline = {
        adapter = "opencode",
        model = "gpt-5-mini",
      },
      cmd = {
        adapter = "opencode",
        model = "gpt-5-mini",
      },
    },
  },
}
