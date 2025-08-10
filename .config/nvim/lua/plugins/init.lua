local config = require("config.config").opts
return {
  -- { "rebelot/kanagawa.nvim", lazy = false, priority = 1000 },
  { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
  {
    "utilyre/barbecue.nvim",
    event = "VeryLazy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
  },
  "nvim-lua/plenary.nvim",
  { "b0o/schemastore.nvim", event = { "VeryLazy" } },
  { "f-person/git-blame.nvim", event = "BufReadPost" },
  { "tpope/vim-abolish", cmd = "Abolish", lazy = true, event = "VeryLazy" },
  { "tpope/vim-surround", event = "BufReadPre" },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
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
    config = function() require("nvim-web-devicons").setup {} end,
  },
  {
    "andweeb/presence.nvim",
    lazy = true,
    event = "User FileOpened",
    cond = function() return vim.fn.executable "discord" == 1 end,
  },
  { "editorconfig/editorconfig-vim" },
  { import = "plugins.languages.csharp", enabled = config.use_dotnet },
  { import = "plugins.dbee.init" },
  { import = "plugins.languages.typescript" },
  { import = "plugins.languages.go", enabled = config.use_go },
  { import = "plugins.languages.rust", enabled = config.use_rust },
  { import = "plugins.languages.python", enabled = config.use_python },
  {
    "m4xshen/smartcolumn.nvim",
    event = "BufReadPost",
    opts = {
      colorcolumn = "80",
      scope = "line",
      disabled_filetypes = { "help", "text", "markdown", "alpha", "Telescope" },
    },
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "VeryLazy",
    config = function() require("lsp_lines").setup() end,
  },
  {
    "windwp/nvim-spectre",
    event = "VeryLazy",
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },
  {
    "akinsho/nvim-bufferline.lua",
    event = "VeryLazy",
    opts = {
      options = {
        mode = "tabs", -- tabs or buffers
        numbers = "buffer_id",
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        separator_style = "slant" or "padded_slant",
        show_tab_indicators = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true,
        enforce_regular_tabs = false,
        custom_filter = function(buf_number, _)
          local tab_num = 0
          for _ in pairs(vim.api.nvim_list_tabpages()) do
            tab_num = tab_num + 1
          end

          if tab_num > 1 then
            if not not vim.api.nvim_buf_get_name(buf_number):find(vim.fn.getcwd(), 0, true) then return true end
          else
            return true
          end
        end,
        sort_by = function(buffer_a, buffer_b)
          local mod_a = ((vim.loop.fs_stat(buffer_a.path) or {}).mtime or {}).sec or 0
          local mod_b = ((vim.loop.fs_stat(buffer_b.path) or {}).mtime or {}).sec or 0
          return mod_a > mod_b
        end,
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    keys = { "gc", "gcc", "gbc" },
    config = function(_, _)
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
    event = { "VeryLazy" },
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
    lazy = false,
    config = function()
      require("eyeliner").setup {
        highlight_on_key = true, -- show highlights only after keypress
        dim = true, -- dim all other characters if set to true (recommended!)
      }
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
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
    event = "VeryLazy",
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
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    cmd = "Oil",
    keys = { { "-", "<cmd>Oil<cr>", desc = "Open parent directory" } },
  },
}
