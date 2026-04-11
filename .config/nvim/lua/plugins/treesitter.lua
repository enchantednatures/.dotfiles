return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = true,
    build = false,
    init = function() vim.g.loaded_nvim_treesitter = true end,
  },

  {
    "lewis6991/ts-install.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = { "TSInstall", "TSUpdate" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("ts-install").setup {
        auto_install = true,
        ensure_installed = {
          "yaml",
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("NativeTreesitter", { clear = true }),
        callback = function(ev)
          local buf = ev.buf
          local ft = vim.bo[buf].filetype
          if ft == "" then return end

          local lang = vim.treesitter.language.get_lang(ft)
          if not lang then return end

          local ok = pcall(vim.treesitter.language.add, lang)
          if not ok then return end

          pcall(vim.treesitter.start, buf, lang)

          if ft ~= "python" then
            vim.bo[buf].indentexpr = "v:lua.vim.treesitter.indentexpr()"
          end
        end,
      })

      vim.keymap.set("n", "gnn", function()
        vim.cmd "normal! v"
      end, { desc = "Start incremental selection" })

      local ok, ts_repeat_move = pcall(require, "nvim-treesitter.textobjects.repeatable_move")
      if ok then
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
      end

      vim.filetype.add {
        extension = {
          hpp = "cpp",
          cpp = "cpp",
          h = "cpp",
          cc = "cpp",
          gotmpl = "gotmpl",
        },
        pattern = {
          [".*/templates/.*%.tpl"] = "helm",
          [".*/templates/.*%.ya?ml"] = "helm",
          ["helmfile.*%.ya?ml"] = "helm",
        },
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    init = function()
      require("lazy.core.loader").disable_rtp_plugin "nvim-treesitter-textobjects"
    end,
  },
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  { "RRethy/nvim-treesitter-endwise", enabled = false },
  { "romgrk/nvim-treesitter-context", event = { "BufReadPost", "BufNewFile" } },
  { "LiadOz/nvim-dap-repl-highlights", lazy = true },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require "nvim-autopairs"
      npairs.setup {
        check_ts = true,
      }
    end,
  },
}
