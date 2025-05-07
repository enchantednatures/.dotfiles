return {
  dir = "~/dev/nvim-dbee",
  lazy = true,
  cmd = { "Dbee" },
  keys = {
    { "<leader>DB", "<cmd>Dbee<cr>", desc = "DBee" },
    { "<leader>Db", "<cmd>Dbee<cr>", desc = "DBee" },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  build = function() require("dbee").install "go" end,
  config = function(_)
    local Slayout = require "plugins.dbee.layout"
    local dbee = require "dbee"

    local slayout = Slayout:new()

    vim.keymap.set("n", "<leader>l", function()
      if dbee.is_open() then slayout:open_popup() end
    end, { noremap = true })

    local opts = {
      install_path = "~/.local/bin",
      window_layout = slayout,
      result = {
        page_size = 10,
      },
    }
    require("dbee").setup(opts)
  end,
}
