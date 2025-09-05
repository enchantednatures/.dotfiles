vim.keymap.set("n", "<leader>cf", function() vim.cmd.RustLsp "flyCheck" end, { desc = "[C]argo [F]lycheck" })
