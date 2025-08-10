return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  opts = {
    integrations = {
      diffview = true,
      telescope = true,
    },
    disable_hint = true,
    disable_context_highlighting = true,
    disable_signs = false,
    git = {
      timeout = 250,
    },
    status = {
      recent_commit_count = 10,
    },
  },
  keys = {
    { "<leader>gs", "<cmd>Neogit kind=tab<cr>", desc = "Status" },
  },
}
