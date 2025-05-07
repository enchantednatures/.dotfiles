local M = {}

local function get_git_root()
  local cmd = "git rev-parse --show-toplevel"
  local handle = assert(io.popen(cmd))
  local result = handle:read("*a"):gsub("\n$", "")
  local success, err = handle:close()
  if not success then
    vim.notify(string.format("Error running command: %s", err), vim.log.levels.ERROR)
    return nil
  end
  return result
end

local function git_has_worktree(branch)
  local cmd = string.format("git worktree list | grep '%s'", branch)
  local handle = io.popen(cmd)
  local result = handle:read "*a"
  handle:close()
  return result ~= ""
end

local function git_create_worktree(branch, path)
  local cmd = string.format("git worktree add %s %s", path, branch)
  vim.fn.system(cmd)
end

function M.create_default_worktree()
  local git_root = get_git_root()
  if not git_root then return end

  local repo_name = git_root:match "([^/]+)$"
  if not repo_name then
    vim.notify("Failed to extract repository name", vim.log.levels.ERROR)
    return
  end

  local dev_path = string.format("~/dev/%s", repo_name)

  local default_branch = "main"
  if not git_has_worktree(default_branch) then default_branch = "master" end

  if not git_has_worktree(default_branch) then
    git_create_worktree(default_branch, dev_path)
    vim.notify(string.format("Created worktree for %s at %s", default_branch, dev_path), vim.log.levels.INFO)
  else
    vim.notify(string.format("Worktree for %s already exists", default_branch), vim.log.levels.INFO)
  end
end

vim.api.nvim_create_user_command("SetupWorktree", function()
  local worktree = require "git-worktree"
  local branch = "main"
  local path = "~/dev/" .. branch

  if not git_has_worktree(branch) then
    worktree.create_worktree(branch, path)
    vim.notify(string.format("Created worktree for %s at %s", branch, path), vim.log.levels.INFO)
  else
    vim.notify(string.format("Worktree for %s already exists", branch), vim.log.levels.INFO)
  end

  worktree.switch_worktree(branch)
end, { desc = "Setup worktree for a specific branch" })

return M
