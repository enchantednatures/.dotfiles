local function is_remote()
  -- return vim.fn.exists("$SSH_CONNECTION") == 1 or vim.fn.exists("$SSH_CLIENT") == 1 or vim.fn.exists("$SSH_TTY") == 1
  return true
end

return {
  "ojroques/nvim-osc52",

  event = "VeryLazy",
  enabled = is_remote() or vim.fn.empty(vim.fn.getenv "DISPLAY") == 1 or vim.fn.exists "$ZELLIJ_SESSION_NAME" == 1,
  config = function()
    local osc52 = require "osc52"

    vim.g.clipboard = {
      name = "osc52",
      copy = {
        ["+"] = function(lines, regtype)
          osc52.copy "+"
          return vim.fn.setreg("+", lines, regtype)
        end,
        ["*"] = function(lines, regtype)
          osc52.copy "*"
          return vim.fn.setreg("*", lines, regtype)
        end,
      },
      paste = {
        ["+"] = function() return vim.fn.getreg "+" end,
        ["*"] = function() return vim.fn.getreg "*" end,
      },
      cache_enabled = 0,
    }

    vim.opt.clipboard = "unnamed,unnamedplus"
    vim.api.nvim_create_autocmd("TextYankPost", {
      group = vim.api.nvim_create_augroup("osc52_highlight", { clear = true }),
      callback = function()
        if vim.v.event.operator == "y" then osc52.copy "+" end
      end,
    })
  end,
}
