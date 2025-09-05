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
    "nvim-treesitter/nvim-treesitter",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown", "codecompanion" },
    },
  },
  opts = {
    strategies = {
      chat = {
        adapter = "copilot",
        model = "gpt-5-mini",
      },
      inline = {
        adapter = "copilot",
        model = "gpt-5-mini",
      },
      cmd = {
        adapter = "copilot",
        model = "gpt-5-mini",
      },
    },
  },
}
