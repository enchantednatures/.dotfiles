return {
  "tpope/vim-fugitive",
  cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit", "G", "GDiff", "Glog" },
  dependencies = {
    "tpope/vim-rhubarb",
  },
  keys = {
    { "<leader>glp", ":G log -p -- % <CR>", desc = "Git Log Patch" },
  },
}
