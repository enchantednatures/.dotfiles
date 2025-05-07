local augroups = require "config.autocommands.augroups"

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = augroups.cmpCargo,
  pattern = { "Cargo.toml" },
  callback = function(event)
    local map = function(mode, lhs, rhs, desc)
      if desc then desc = desc end
      vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = event.buf, noremap = true })
    end
    map("n", "<leader>lc", function() end, "+Crates")
    map("n", "<leader>lcy", "<cmd>lua require'crates'.open_repository()<cr>", "Open Repository")
    map("n", "<leader>lcp", "<cmd>lua require'crates'.show_popup()<cr>", "Show Popup")
    map("n", "<leader>lci", "<cmd>lua require'crates'.show_crate_popup()<cr>", "Show Info")
    map("n", "<leader>lcf", "<cmd>lua require'crates'.show_features_popup()<cr>", "Show Features")
    map("n", "<leader>lcd", "<cmd>lua require'crates'.show_dependencies_popup()<cr>", "Show Dependencies")
  end,
})
