return {
  name = "Neotest: Run Current File",
  builder = function()
    return {
      name = "neotest_current_file",
      -- Use `components` if you want output handling, status, etc.
      components = { "default" },
      -- A lua function to run neotest
      run = function()
        local neotest = require "neotest"
        neotest.run.run(vim.fn.expand "%")
      end,
    }
  end,
  desc = "Run neotest on current file",
  priority = 50,
  condition = {
    filetype = { "lua", "python", "go", "typescript", "javascript", "rust" }, -- adjust as needed
  },
}
