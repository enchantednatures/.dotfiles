require "config.autocommands.general"
require "config.autocommands.lsp"
require "config.autocommands.worktree"
-- require "config.autocommands.cargo"

vim.api.nvim_create_user_command("OverseerRestartLast", function()
  local overseer = require "overseer"
  local tasks = overseer.list_tasks { recent_first = true }
  if vim.tbl_isempty(tasks) then
    vim.notify("No tasks found", vim.log.levels.WARN)
  else
    overseer.run_action(tasks[1], "restart")
  end
end, {})

vim.api.nvim_create_user_command("OverseerPopOut", function()
  local overseer = require "overseer"
  local tasks = overseer.list_tasks { recent_first = true }
  if vim.tbl_isempty(tasks) then
    vim.notify("No tasks found", vim.log.levels.WARN)
  else
    -- move the task to a new tab
    overseer.run_action(tasks[1], "pop_out")
  end
end, {})
