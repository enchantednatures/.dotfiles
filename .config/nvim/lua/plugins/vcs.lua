local icons = require("config.icons").git
local function toggle_diffview(cmd)
  if next(require("diffview.lib").views) == nil then
    vim.cmd(cmd)
  else
    vim.cmd "DiffviewClose"
  end
end

function toggle_diffview()
  if next(require("diffview.lib").views) == nil then
    vim.cmd "DiffviewOpen"
  else
    vim.cmd "DiffviewClose"
  end
end

return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    config = true,
    keys = {
      { "<leader><leader>v", toggle_diffview, "Toggle Diff View" },
      {
        "<leader>gd",
        function() toggle_diffview "DiffviewOpen" end,
        desc = "Diff Index",
      },
      {
        "<leader>gD",
        function() toggle_diffview "DiffviewOpen master..HEAD" end,
        desc = "Diff master",
      },
      {
        "<leader>gf",
        function() toggle_diffview "DiffviewFileHistory %" end,
        desc = "Open diffs for current File",
      },
    },
  },
  {
    -- dir = "~/source/octo.nvim.git/octo.nvim",
    "pwntester/octo.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      default_merge_method = "squash",
      mappings = {
        pull_request = {
          merge_pr = {
            lhs = "<leader>pm",
            desc = "merge commit PR",
          },
        },
      },
    },
    cmd = { "Octo" },
    keys = {
      { "<leader>pr", "<cmd>Octo pr list <cr>", "List [P]ull [R]equests" },
      { "<leader>gp", "<cmd>Octo pr list <cr>", "List [P]ull [R]equests" },
      { "<leader>gil", "<cmd>Octo issue list <cr>", "List [G]it [I]ssues [L]ist" },
      { "<leader>gic", "<cmd>Octo issue create <cr>", "List [G]it [I]ssues [C]reate" },
      { "<leader>ci", "<cmd>Octo run list <cr>", "List Github Actions" },
    },
  },
  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    opts = {
      integrations = { diffview = true },
    },
    keys = {
      { "<leader>gs", "<cmd>Neogit kind=tab<cr>", desc = "Status" },
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit", "G", "GDiff", "Glog" },
    dependencies = {
      "tpope/vim-rhubarb",
    },
    keys = {
      { "<leader>glp", ":G log -p -- % <CR>", desc = "Git Log Patch" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = {
          -- hl = "GitSignsAdd",
          text = "▍",
          -- numhl = "GitSignsAddNr",
          -- linehl = "GitSignsAddLn"
        },
        change = {
          -- hl = "GitSignsChange",
          text = icons.Changed,
          -- numhl = "GitSignsChangeNr",
          -- linehl = "GitSignsChangeLn",
        },
        delete = {
          -- hl = "GitSignsDelete",
          text = icons.Deleted,
          -- numhl = "GitSignsDeleteNr",
          -- linehl = "GitSignsDeleteLn",
        },
        topdelete = {
          -- hl = "GitSignsDelete",
          text = icons.TopDelete,
          -- numhl = "GitSignsDeleteNr",
          -- linehl = "GitSignsDeleteLn",
        },
        changedelete = {
          -- hl = "GitSignsChange",
          text = icons.ChangeDelete,
          -- numhl = "GitSignsChangeNr",
          -- linehl = "GitSignsChangeLn",
        },
      },
      -- update_debounce = 100,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map("n", "]c", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[c", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, { expr = true })

        -- Actions
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
        map("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage Buffer" })
        map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
        map("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset Buffer" })
        map("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview Hunk" })
        map("n", "<leader>ghb", function() gs.blame_line { full = true } end, { desc = "Blame Line" })
        map("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Toggle Line Blame" })
        map("n", "<leader>ghd", gs.diffthis, { desc = "Diff This" })
        map("n", "<leader>ghD", function() gs.diffthis "~" end, { desc = "Diff This ~" })
        map("n", "<leader>gtd", gs.toggle_deleted, { desc = "Toggle Delete" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Hunk" })
      end,
    },
  },
}
