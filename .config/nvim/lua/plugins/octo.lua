return {
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
}
