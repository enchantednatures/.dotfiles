vim.g.mapleader = " "

require "config.options"
require "config.lazy"
require "config.lsp"
require "config.colorscheme"
require "config.autocommands"

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require "config.keymaps"
    require "config.diagnostics"
  end,
})
