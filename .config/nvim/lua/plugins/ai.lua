return {
  "olimorris/codecompanion.nvim",
  lazy = "VeryLazy",
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
        adapter = "groq",
      },
      inline = {
        adapter = "groq",
      },
      cmd = {
        adapter = "groq",
      },
    },
    adapters = {
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          env = {
            url = "http://gateway",
            api_key = "OLLAMA_API_KEY",
          },
          headers = {
            ["Content-Type"] = "application/json",
            ["Authorization"] = "Bearer ${api_key}",
          },
          parameters = {
            sync = true,
          },
        })
      end,
      groq = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          env = {
            chat_url = "openai/v1/chat/completions", -- optional: default value, override if different
            models_endpoint = "/v1/models",
            url = "https://api.groq.com/",
            api_key = "cmd:atuin kv get groq",
          },
          schema = {
            model = {
              default = "openai/gpt-oss-120b",
            },
          },
        })
      end,
    },
  },
}
