local function toggle_gitignore()
  local api = require "nvim-tree.api"
  local node = api.tree.get_node_under_cursor()
  local absolute_path = node.absolute_path
  local relative_path = vim.fn.fnamemodify(absolute_path, ":.")
  vim.cmd("silent !echo " .. relative_path .. " >> .gitignore")
end

local function get_add()
  local api = require "nvim-tree.api"

  local node = api.tree.get_node_under_cursor()
  local gs = node.git_status.file

  -- If the current node is a directory get children status
  if gs == nil then
    gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1])
      or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
  end

  -- If the file is untracked, unstaged or partially staged, we stage it
  if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
    vim.cmd("silent !git add " .. node.absolute_path)

    -- If the file is staged, we unstage
  elseif gs == "M " or gs == "A " then
    vim.cmd("silent !git restore --staged " .. node.absolute_path)
  end

  api.tree.reload()
end

return {
  "nvim-tree/nvim-tree.lua",
  lazy = true,
  cmd = { "NvimTreeToggle" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
    { "<esc>", "<cmd>NvimTreeClose<cr>", desc = "Explorer" },
    { "ga", get_add, "Toggle Git Staged" },
    { "gi", toggle_gitignore, "Toggle Git Ignore" },
    -- { "t",         open_tab_silent,           "open tab silent" }
  },
  opts = {
    disable_netrw = false,
    hijack_netrw = true,
    respect_buf_cwd = true,
    git = {
      enable = true,
      timeout = 200, -- Reduced timeout for better performance
      ignore = false, -- Don't ignore files in .gitignore
    },
    view = {
      number = true,
      relativenumber = true,
      float = {
        enable = true,
        open_win_config = function()
          local HEIGHT_RATIO = 0.8 -- You can change this
          local WIDTH_RATIO = 0.5 -- You can change this too
          local screen_w = vim.opt.columns:get()
          local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
          local window_w = screen_w * WIDTH_RATIO
          local window_h = screen_h * HEIGHT_RATIO
          local window_w_int = math.floor(window_w)
          local window_h_int = math.floor(window_h)
          local center_x = (screen_w - window_w) / 2
          local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
          return {
            border = "rounded",
            relative = "editor",
            row = center_y,
            col = center_x,
            width = window_w_int,
            height = window_h_int,
          }
        end,
      },
      width = function()
        local WIDTH_RATIO = 0.5 -- You can change this too
        return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
      end,
    },
    filters = {
      -- custom = { ".git" },
    },
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      -- update_root = true,
    },
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
    renderer = {
      highlight_git = true,
      icons = {
        show = {
          git = true,
        },
      },
    },
  },
}
