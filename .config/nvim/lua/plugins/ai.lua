local config_opts = require("config.config").opts

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  build = "make",
  cmd = {
    "AvanteAsk",
  },
  keys = {
    { "<leader>aa", "<cmd>AvanteAsk<cr>", desc = "Show Avante Sidebar", mode = { "n" } },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  opts = {
    disabled_tools = { "python" },
    provider = config_opts.default_provider,
    cursor_applying_provider = config_opts.default_cursor_applying_provider,
    behaviour = {
      auto_suggestions = false,
      enable_cursor_planning_mode = config_opts.enable_cursor_planning_mode,
      auto_apply_diff_after_generation = false,
    },
    dual_boost = { enabled = false },
    openai = {
      endpoint = "https://api.openai.com/v1",
      model = "o3-mini",
      reasoning_effort = "medium",
      api_key_name = { "atuin", "kv", "get", "openai" },
    },
    claude = {
      api_key_name = { "atuin", "kv", "get", "claude" },
      model = "claude-3-5-sonnet-20241022",
      max_tokens = 1000,
      disable_tools = true,
    },
    vendors = {
      groq = {
        __inherited_from = "openai",
        api_key_name = { "atuin", "kv", "get", "groq" },
        endpoint = "https://api.groq.com/openai/v1/",
        model = "meta-llama/llama-4-maverick-17b-128e-instruct",
        max_tokens = 8192,
        disable_tools = true,
      },
      open_router = {
        __inherited_from = "openai",
        api_key_name = { "atuin", "kv", "get", "openrouter" },
        endpoint = "https://openrouter.ai/api/v1",
        model = "google/gemini-2.5-pro-preview-03-25",
      },
    },
  },
}
