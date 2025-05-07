local config_opts = require("config.config").opts
return {
  {
    "milanglacier/minuet-ai.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = true,
    opts = {
      provider = "openai_compatible",
      request_timeout = 2,
      throttle = 2000,
      blink = {
        enable_auto_complete = true,
      },
      context_window = 512,
      virtualtext = {},
      notify = "error",
      provider_options = {
        openai_compatible = {
          api_key = "GROQ_API_KEY",
          end_point = "https://api.groq.com/openai/v1/chat/completions",
          model = "meta-llama/llama-4-maverick-17b-128e-instruct",
          name = "Groq",
          optional = {
            max_tokens = 512,
            top_p = 0.9,
          },
        },
        -- openai_compatible = {
        --   api_key = "TERM",
        --   end_point = "http://localhost:1234/v1/chat/completions",
        --   model = "qwen2.5-coder-3b-instruct",
        --   name = "Ollama",
        --   optional = {
        --     max_tokens = 56,
        --     top_p = 0.9,
        --   },
        -- },
      },
    },

    cond = config_opts.use_minuet,
    event = { "InsertEnter", "VeryLazy" },
    config = function(_, opts)
      local minuet = require "minuet"
      -- minuet = "󱗻",
      minuet.setup(opts)
    end,
  },
}
