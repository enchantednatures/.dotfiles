local augroups = require "config.autocommands.augroups"
local M = {}

function M.is_bare_repo()
  local bare_repo = vim.fn.system "git rev-parse --is-bare-repository"
  return vim.trim(bare_repo) == "true"
end

function M.get_worktrees()
  local worktrees = vim.fn.system "git worktree list"
  local worktrees_list = {}
  for worktree in worktrees:gmatch "([^\n]+)" do
    table.insert(worktrees_list, worktree)
  end
  return worktrees_list
end

function M.get_main_worktree(worktrees)
  if #worktrees == 0 then
    vim.notify("No worktrees found", vim.log.levels.WARN)
    return nil
  end

  local porcelain_output = vim.fn.systemlist "git worktree list --porcelain"
  local current_worktree = nil
  local current_path = nil

  for _, line in ipairs(porcelain_output) do
    if line:match "^worktree " then
      current_path = line:match "^worktree%s+(.+)$"
    elseif line:match "^branch " then
      local branch = line:match "^branch%s+refs/heads/(.+)$"
      if branch == "main" or branch == "master" then
        current_worktree = current_path
        break
      end
    end
  end

  return current_worktree
end

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  group = augroups.worktrees,
  once = true,
  callback = function()
    if M.is_bare_repo() then
      local worktrees = M.get_worktrees()
      if #worktrees == 0 then
        vim.notify("No worktrees found, exiting", vim.log.levels.WARN)
        return
      end
      local main_worktree = M.get_main_worktree(worktrees)
      if main_worktree ~= nil then
        vim.notify("Switching to main worktree: " .. main_worktree, vim.log.levels.INFO)
        require("git-worktree").switch_worktree(main_worktree)
      end
    end
  end,
})
