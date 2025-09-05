return {
  "pmizio/typescript-tools.nvim",
  lazy = true,
  ft = {
    "typescript",
    "javascript",
  },
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {
    code_lens = "all",
  },
}
