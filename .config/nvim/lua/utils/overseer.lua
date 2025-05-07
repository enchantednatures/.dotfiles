local overseer = require "overseer"
vim.api.nvim_create_user_command("Grep", function(params)
  -- Insert args at the '$*' in the grepprg
  local cmd, num_subs = vim.o.grepprg:gsub("%$%*", params.args)
  if num_subs == 0 then cmd = cmd .. " " .. params.args end
  local task = overseer.new_task {
    cmd = vim.fn.expandcmd(cmd),
    components = {
      {
        "on_output_quickfix",
        errorformat = vim.o.grepformat,
        open = not params.bang,
        open_height = 8,
        items_only = true,
      },
      -- We don't care to keep this around as long as most tasks
      { "on_complete_dispose", timeout = 30 },
      "default",
    },
  }
  task:start()
end, { nargs = "*", bang = true, complete = "file" })
