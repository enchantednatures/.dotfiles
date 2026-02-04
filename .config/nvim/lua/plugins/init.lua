return {
  { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, lazy = false },
  { "neovim/nvim-lspconfig", event = { "BufReadPre", "BufNewFile" } },
  {
    "utilyre/barbecue.nvim",
    event = { "LspAttach" },
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
  },
  { "nvim-lua/plenary.nvim", lazy = true },
  { "b0o/schemastore.nvim", ft = { "json", "yaml" } },
  { "tpope/vim-abolish", cmd = "Abolish" },
  { "tpope/vim-surround", keys = { "ys", "ds", "cs" } },
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load { plugins = { "dressing.nvim" } }
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load { plugins = { "dressing.nvim" } }
        return vim.ui.input(...)
      end
    end,
    opts = {
      input = { relative = "editor" },
      select = {
        backend = { "telescope", "fzf", "builtin" },
      },
    },
  },
  {
    "andymass/vim-matchup",
    lazy = true,
    event = { "BufReadPost" },
    config = function() vim.g.matchup_matchparen_offscreen = { method = "popup" } end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function() require("nvim-web-devicons").setup {} end,
  },
  { "editorconfig/editorconfig-vim", event = { "BufReadPre", "BufNewFile" } },
  { import = "plugins.dbee.init" },
  {
    "m4xshen/smartcolumn.nvim",
    event = "BufReadPost",
    opts = {
      colorcolumn = "80",
      scope = "line",
      disabled_filetypes = { "help", "text", "markdown", "alpha", "Telescope" },
    },
  },
  -- {
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   event = "VeryLazy",
  --   config = function() require("lsp_lines").setup() end,
  -- },
  {
    "windwp/nvim-spectre",
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    keys = { "gc", "gcc", "gbc" },
    config = function(_, _)
      vim.g.skip_ts_context_commentstring_module = true
      local opts = {
        ignore = "^$",
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        opleader = {
          line = "gc",
          block = "gb",
        },
        mappings = {
          basic = true,
          extra = true,
        },
      }
      require("Comment").setup(opts)
    end,
  },
  {
    "chentoast/marks.nvim",
    keys = { "m", "'", "`", "dm" },
    event = { "BufReadPost" },
    config = function()
      local marks = require "marks"
      marks.setup {
        default_mappings = true,
        builtin_marks = { ".", "<", ">", "^" },
        cyclic = true,
        force_write_shada = false,
        refresh_interval = 150,
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        excluded_filetypes = {},
        bookmark_0 = {
          sign = "⚑",
          virt_text = "hello world",
          -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
          -- defaults to false.
          annotate = false,
        },
      }
    end,
    mappings = {},
  },
  {
    "jinh0/eyeliner.nvim",
    keys = { "f", "F", "t", "T" },
    opts = {
      highlight_on_key = true, -- show highlights only after keypress
      dim = true, -- dim all other characters if set to true (recommended!)
    },
  },
  {
    "folke/flash.nvim",
    keys = { "s", "S", "r", "R" },
    opts = {
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
    -- stylua: ignore
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          local flash = require("flash")
          local gi = vim.go.ignorecase
          local gs = vim.go.smartcase
          vim.go.ignorecase = true
          vim.go.smartcase = true
          flash.jump()
          vim.go.ignorecase = gi
          vim.go.smartcase = gs
        end,
        desc = "Flash"
      },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  {
    "monaqa/dial.nvim",
    keys = {
      { "<C-a>", function() require("dial.map").inc_normal()() end, desc = "Increment" },
      { "<C-x>", function() require("dial.map").dec_normal()() end, desc = "Decrement" },
      { "<C-a>", function() require("dial.map").inc_visual()() end, mode = "v", desc = "Increment" },
      { "<C-x>", function() require("dial.map").dec_visual()() end, mode = "v", desc = "Decrement" },
      { "g<C-a>", function() require("dial.map").inc_gvisual()() end, mode = "v", desc = "Increment" },
      { "g<C-x>", function() require("dial.map").dec_gvisual()() end, mode = "v", desc = "Decrement" },
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    enabled = true, -- can be disabled with neovim nightly as LazyVim implements folding too
    dependencies = {
      "kevinhwang91/promise-async",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      vim.o.foldcolumn = "0" -- '0' does not show the fold column, higher values increase the width
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      require("ufo").setup {
        provider_selector = function(_, _, _) return { "treesitter", "indent" } end,
      }
    end,
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = true,
    -- stylua: ignore
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next ToDo" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous ToDo" },
      { "<leader>ct", "<cmd>TodoTelescope<cr>",                            desc = "ToDo" },
      { "<leader>tT", "<cmd>TodoTelescope<cr>",                            desc = "ToDo" },
    },
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = false },
  },
  {
    "windwp/windline.nvim",
    event = "UIEnter",
    config = function() require "wlsample.airline" end,
  },
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    keys = {
      { "<leader>Rs", desc = "Send request" },
      { "<leader>Ra", desc = "Send all requests" },
      { "<leader>Rb", desc = "Open scratchpad" },
    },
    opts = {
      -- your configuration comes here
      global_keymaps = true,
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { "nvim-dap-ui" },
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    dependencies = {
      "folke/twilight.nvim",
    },
    cmd = { "ZenMode" },
    keys = {
      { "<leader>zm", "<CMD>ZenMode <CR>", desc = "Toggle [Z]en [M]ode" },
    },
    opts = {
      window = {
        width = 0.40, -- width will be 85% of the editor width
      },
      {
        plugins = {
          options = {
            enabled = true,
          },
          twilight = { enabled = true },
          gitsigns = { enabled = false },
          todo = { enabled = true },
        },
      },
    },
  },
}
