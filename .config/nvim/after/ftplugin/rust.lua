local rust_utils = require "utils.rust"

vim.keymap.set("n", "<leader>cf", function() vim.cmd.RustLsp "flyCheck" end, { desc = "[C]argo [F]lycheck" })

-- local dap = require "dap"

-- local codelldb_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/bin/codelldb")

-- dap.adapters.codelldb = {
--   type = "executable",
--   command = codelldb_path, -- adjust as needed
--   name = "codelldb",
-- }

-- local packages = rust_utils.get_rust_targets()

-- dap.configurations.rust = {}
-- for _, target in ipairs(packages) do
--   table.insert(dap.configurations.rust, {

--     type = "codelldb",
--     name = "Debug " .. target,
--     request = "launch",
--     program = function() return vim.fn.getcwd() .. "/target/debug/" .. target end,
--     cwd = "${workspaceFolder}",
--     stopOnEntry = false,
--   })
-- end
