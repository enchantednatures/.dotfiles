return {
  {
    "nvim-telescope/telescope.nvim",
    -- lazy = true,
    -- event = { "VeryLazy", "BufReadPost" },
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-file-browser.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      {
        "ThePrimeagen/git-worktree.nvim",
        config = function(_, opts)
          local telescope = require "telescope"
          telescope.load_extension "git_worktree"
        end,
        keys = {
          {
            "<leader>tt",
            "<cmd>Telescope git_worktree git_worktrees <cr>",
            desc = "Git Work[t]ree",
          },
        },
      },
      -- "cljoly/telescope-repo.nvim",
      "debugloop/telescope-undo.nvim",
      "molecule-man/telescope-menufacture",
      "kkharji/sqlite.lua",
    },
    cmd = "Telescope",
    keys = {

      {
        "<leader>sw",
        function(curr) require("telescope.builtin").grep_string(curr) end,
        desc = "[S]earch [w]ord under cursor",
      },
      {
        "<leader>/",
        function()
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end,
        desc = "[/] Fuzzily search in current buffer]",
      },
      {
        "<leader><leader>f",
        "<cmd>Telescope find_files <cr>",
        desc = "Find Files",
      },
      {
        "<leader>tf",
        require("utils").find_files,
        desc = "Find Files",
      },
      {
        "<leader>ff",
        require("telescope.builtin").find_files,
        desc = "Find Files",
      },
      {
        "<leader><tab>",
        "<Cmd>lua require('telescope.builtin').commands()<CR>",
        desc = "Telescope Commands",
      },
      {
        "<leader>th",
        "<Cmd>Telescope help_tags<cr>",
        desc = "[T]elescope [H]elp",
      },
      {
        "<leader>tk",
        ":lua require('telescope.builtin').keymaps()<CR>",
        desc = "[T]elescope [K]eys",
      },
      {
        "<leader>to",
        "<cmd>Telescope buffers<cr>",
        desc = "Open Buffers",
      },
      {
        "<leader>tg",
        "<cmd>Telescope repo list<cr>",
        desc = "Git Repos",
      },
      {
        "<leader>cd",
        "<cmd>Telescope diagnostics<cr>",
        desc = "Document Diagnostics",
      },
      {
        "<leader>t'",
        function() require("telescope.builtin").registers() end,
        desc = "Registers",
      },
      {
        "<leader>tm",
        function() require("telescope.builtin").marks() end,
        desc = "Marks",
      },
      {
        "<leader>td",
        function() require("telescope.builtin").diagnostics { sort_by = "severity" } end,
        desc = "[T]elescope Workspace [D]iagnostics",
      },
      {
        "<leader>ts",
        function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
        desc = "[W]orkspace [S]ymbols",
      },
      {
        "<leader>ty",
        function() require("telescope.builtin").spell_suggest() end,
        desc = "Spell Check/Skill Issue (Same thing)",
      },
      {
        "<leader>tp",
        function() require("telescope").extensions.project.project { display_type = "minimal" } end,
        desc = "Projects",
      },
      {
        "<leader>t<tab>",
        function() require("telescope.builtin").resume() end,
        desc = "Resume",
      },
      {
        "<leader>tw",
        function() require("telescope").extensions.menufacture.live_grep() end,
        desc = "Workspace",
      },
      {
        "<leader>tr",
        "<cmd>Telescope oldfiles<cr>",
        desc = "Recents",
      },
      {
        "<leader>tb",
        function() require("telescope.builtin").current_buffer_fuzzy_find() end,
        desc = "Buffer",
      },

      {
        "<leader>zc",
        function() require("telescope.builtin").colorscheme { enable_preview = true } end,
        desc = "Colorscheme",
      },
      {
        "<leader>U",
        "<cmd>Telescope undo<cr>",
        desc = "Undo",
      },
      {
        "<leader>sB",
        function() require("telescope.builtin").git_branches() end,
        desc = "Git branches",
      },
      {
        "<leader>sm",
        function() require("telescope.builtin").git_status() end,
        desc = "Git status",
      },
      {
        "<leader><leader>s",
        function()
          local word = vim.fn.expand "<cWORD>"
          require("telescope.builtin").grep_string { search = word }
        end,
      },
      {
        "<leader>gb",
        function() require("telescope.builtin").git_branches() end,
        desc = "[G]it [B]ranches",
      },
      {
        "<leader>gcH",
        function() require("telescope.builtin").git_bcommits() end,
        desc = "[G]it [C]ommit [H]istory: Current Buffer",
      },
      {
        "<leader>gch",
        function() require("telescope.builtin").git_bcommits_range() end,
        mode = "v",
        desc = "[G]it [C]ommit [H]istory",
      },
      {
        "<leader>gch",
        function() require("telescope.builtin").git_commits() end,
        desc = "[G]it [C]ommit [H]istory",
      },
      {
        "<leader>gS",
        function() require("telescope.builtin").git_stash() end,
        desc = "[G]it [S]tash",
      },
    },
    opts = function(_, opts) end,

    config = function(_, opts)
      local telescope = require "telescope"

      local function flash(prompt_bufnr)
        require("flash").jump {
          pattern = "^",
          label = { after = { 0, 0 } },
          search = {
            mode = "search",
            exclude = {
              function(win) return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults" end,
            },
          },
          action = function(match)
            local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            picker:set_selection(match.pos[1] - 1)
          end,
        }
      end
      local icons = require "config.icons"
      local actions = require "telescope.actions"
      local actions_layout = require "telescope.actions.layout"
      local mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          -- ["<c-t>"] = trouble.open_with_trouble,
          ["?"] = actions_layout.toggle_preview,
        },
        n = {
          -- ["<c-t>"] = trouble.open_with_trouble,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
      }

      opts = vim.tbl_deep_extend("force", opts, {
        defaults = {
          prompt_prefix = icons.ui.Telescope .. " ",
          selection_caret = icons.ui.Forward .. " ",
          mappings = mappings,
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          preview = {
            -- Skip TreeSitter highlighting for filetypes without parsers
            treesitter = {
              disable = { "zsh" },
            },
          },
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            previewer = false,
            hidden = true,

            path_display = { "tail" },
            find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
          },
          git_files = {
            path_display = { "truncate" },
            theme = "dropdown",
            previewer = true,
          },
          buffers = {
            theme = "dropdown",
            previewer = false,
          },
        },
        extensions = {
          file_browser = {
            theme = "dropdown",
            previewer = true,
            hijack_netrw = true,
            mappings = mappings,
          },
          project = {
            hidden_files = false,
            theme = "dropdown",
          },
          menufacture = {
            mappings = {
              main_menu = { [{ "i", "n" }] = "<C-^>" },
            },
          },
          repo = {
            list = {
              search_dirs = {
                "~/developer/",
                "~/dev/",
                "~/source/",
                "~/projects/",
                "~/work/",
              },
            },
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              initial_mode = "normal",
              codeactions = true,
            },
          },
          undo = {
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.8,
            },
            mappings = {
              i = {
                ["<cr>"] = require("telescope-undo.actions").yank_additions,
                ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                ["<C-cr>"] = require("telescope-undo.actions").restore,
              },
            },
          },
        },
      })

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        mappings = {
          n = { s = flash },
          i = { ["<c-f>"] = flash },
        },
      })

      telescope.setup(opts)
      telescope.load_extension "fzf"
      telescope.load_extension "file_browser"
      telescope.load_extension "project"
      telescope.load_extension "menufacture"
      telescope.load_extension "undo"
      telescope.load_extension "ui-select"
    end,
  },
  -- Kafka (lazy-load on key)
  {
    "krisajenkins/telescope-kafka.nvim",
    lazy = true,
    keys = {
      {
        "<Leader>kt",
        function()
          require("telescope").load_extension "telescope_kafka"
          require("telescope").extensions.telescope_kafka.kafka_topics()
        end,
        desc = "[K]afka [T]opics",
      },
    },
    opts = { kcat_path = "/opt/homebrew/bin/kcat" },
  },
  -- CNPG (lazy-load on key)
  {
    dir = "~/dev/telescope-cnpg.nvim",
    keys = {
      {
        "<leader>tm",
        function()
          require("telescope").load_extension "cnpg"
          require("telescope").extensions.cnpg.workspace()
        end,
        desc = "Find CNPG Resources (Workspace)",
      },
    },
  },
  -- Aerial (lazy-load on key)
  {
    "stevearc/aerial.nvim",
    lazy = true,
    config = function(_, opts)
      local telescope = require "telescope"
      require("aerial").setup(opts)
      telescope.load_extension "aerial"
    end,
    keys = {
      {
        "<leader>ta",
        "<cmd>Telescope aerial<cr>",
        desc = "Aerial Code Outline",
      },
    },
  },
  {
    "enchantednatures/topsail.nvim",
    -- dir = "~/dev/topsail.nvim",
    lazy = true,
    --- @type TopsailConfig
    opts = {
      notify = true,
      default_register = function() return "x" end,
      keymaps = {
        apply = "<leader>ka",
        create = "<leader>kc",
        copy = "<leader>ky",
      },
    },
    cmd = {
      "KubernetesApply",
      "KubernetesCreate",
    },
    config = function(_, opts) require("topsail").setup(opts) end,
    keys = {
      {
        "<leader>ky",
        function() require("topsail").copy_resource() end,
        desc = "Copy current YAML resource to register",
      },
      {
        "<leader>tc",
        function()
          require("telescope").load_extension "topsail"
          require("telescope").extensions.topsail.workspace()
        end,
        desc = "Find Kubernetes Resources (Workspace)",
      },
    },
  },
}
