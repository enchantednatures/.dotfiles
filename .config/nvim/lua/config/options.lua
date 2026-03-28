-- ============================================================================
-- Module: options.lua
-- Description: Core Vim options and settings
-- ============================================================================

-- ============================================================================
-- UI & Display
-- ============================================================================
vim.opt.termguicolors = true -- Enable true colors
vim.opt.signcolumn = "yes:1" -- Always show sign column
vim.opt.guicursor = "" -- Disable cursor styling
vim.opt.nu = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.scrolloff = 8 -- Keep 8 lines above/below cursor
vim.opt.laststatus = 3 -- Global statusline
vim.opt.splitkeep = "screen" -- Prevent splits from jumping
--vim.opt.colorcolumn = "80" -- Column guide at 80 chars

-- ============================================================================
-- Indentation & Formatting
-- ============================================================================
vim.opt.tabstop = 4 -- Tab width
vim.opt.softtabstop = 4 -- Spaces for tab in insert mode
vim.opt.shiftwidth = 4 -- Indentation width
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.wrap = false -- No line wrapping
vim.opt.shiftround = true -- Round indent to shiftwidth

-- ============================================================================
-- Search & Replace
-- ============================================================================
vim.opt.hlsearch = false -- Don't highlight search results
vim.opt.incsearch = true -- Incremental search
vim.opt.ignorecase = true -- Ignore case in search
vim.opt.smartcase = true -- Override ignorecase if search has uppercase

-- ============================================================================
-- Files & Backups
-- ============================================================================
vim.opt.swapfile = false -- Disable swap files
vim.opt.backup = false -- Disable backups
vim.opt.undofile = true -- Persistent undo
vim.opt.undodir = vim.fn.stdpath "data" .. "/undodir" -- Undo file directory
vim.opt.autoread = true -- Auto-reload changed files
vim.opt.autowrite = true -- Auto-save before commands

-- ============================================================================
-- Completion & Popup
-- ============================================================================
vim.o.completeopt = "menuone,noinsert,noselect"
vim.opt.pumblend = 7 -- Popup window transparency
vim.opt.pumheight = 20 -- Max items in popup
vim.opt.wildoptions = "pum" -- Command-line completion menu

-- ============================================================================
-- Editor Behavior
-- ============================================================================
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.updatetime = 100 -- Faster completion
vim.opt.shortmess = vim.opt.shortmess + "c" -- Don't show completion messages
vim.opt.isfname:append "@-@" -- Include @ in filenames

-- ============================================================================
-- Diff Options
-- ============================================================================
vim.opt.diffopt = {
  "internal",
  "filler",
  "closeoff",
  "context:12",
  "algorithm:histogram",
  "linematch:200",
  "indent-heuristic",
  "iwhite", -- Toggle this for whitespace-insensitive diffs
}
