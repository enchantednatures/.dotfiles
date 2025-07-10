local M = {}

local Job = require "plenary.job"

function M.changed_files()
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"
  local conf = require("telescope.config").values
  
  local base_branch = "main"

  -- Determine if 'main' or 'master' is the base branch
  Job:new({
    command = "git",
    args = { "show-ref", "--verify", "--quiet", "refs/heads/main" },
    on_exit = function(j, return_val)
      if return_val ~= 0 then base_branch = "master" end

      Job:new({
        command = "git",
        args = { "diff", "--name-only", base_branch },
        on_exit = function(j, return_val)
          if return_val == 0 then
            local result = j:result()

            vim.schedule(function()
              pickers
                .new({}, {
                  prompt_title = "Changed Files",
                  finder = finders.new_table {
                    results = result,
                  },
                  sorter = conf.generic_sorter {},
                  attach_mappings = function(prompt_bufnr, map)
                    actions.select_default:replace(function()
                      actions.close(prompt_bufnr)
                      local selection = action_state.get_selected_entry()
                      vim.cmd("edit " .. selection[1])
                    end)
                    return true
                  end,
                })
                :find()
            end)
          else
            print "Failed to get changed files."
          end
        end,
      }):start()
    end,
  }):start()
end

vim.api.nvim_create_user_command("TelescopeChanged", function() M.changed_files() end, {})

return M
