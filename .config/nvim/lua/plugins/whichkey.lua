return {
  {
    "folke/which-key.nvim",
    keys = {
      {
        "<leader>?",
        function() require("which-key").show { global = false } end,
        desc = "Buffer Local Keymaps (which-key)",
      },
      { "<leader>" },
    },
    opts = {
      preset = "modern",
      show_help = true,
      plugins = {
        spelling = {
          enabled = true,
          suggestions = 21,
        },
        marks = true,
        registers = true,
        presets = {
          operators = true, -- adds help for operators like d, y, ...
          motions = true, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
      triggers = { "<auto>", mode = "nixsotc" },
      spec = {
        { "<leader>D", group = "+Database" },
        { "<leader>T", group = "+Test" }, -- N = { name = "Neotest" }, o = { "Overseer" } },
        { "<leader>O", group = "+Overseer" },
        { "<leader>a", group = "+A.I." },
        { "<leader>b", group = "+Buffer" },
        { "<leader>d", group = "+Debug" }, -- move to hydra except breakpoints and run
        -- { "<leader>f",  group = "+File" },
        { "<leader>g", group = "+Git" },
        { "<leader>h", group = "+Help" },
        { "<leader>p", group = "+Project" },
        { "<leader>t", group = "+Telescope" },
        { "<leader>v", group = "+View" },
        { "<leader>z", group = "+System" },
        {
          -- Nested mappings are allowed and can be added in any order
          -- Most attributes can be inherited or overridden on any level
          -- There's no limit to the depth of nesting
          mode = { "n", "v" }, -- NORMAL and VISUAL mode
          { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
          { "<leader>qt", "<cmd>tabclose<cr>", desc = "Close Tab" }, -- no need to specify mode since it's inherited
          { "<leader>w", "<cmd>w<cr>", desc = "Write" },
          { "<leader>wq", "<cmd>x<cr>", desc = "Write and Quit" },
          { "<leader>;", "<cmd>Alpha<cr>", desc = "Dashboard" },
        },
      },
    },
    event = "VeryLazy",
  },
}
