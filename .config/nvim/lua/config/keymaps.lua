-- ============================================================================
-- Module: keymaps.lua
-- Description: Core keymaps (non-plugin specific)
-- Dependencies: None
-- ============================================================================

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- Disable space in normal and visual mode (leader key)
keymap({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Center Text on the Screen {{{
local remapList = {
  "<CR>",
  "gg",
  "H",
  "L",
  "%",
  "<c-o>",
  "<c-u>",
  "<c-d>",
  "<c-j>",
  "<c-n>",
  "<c-m>",
  "-",
  "+",
  "_",
  "{",
  "}",
  "[[",
  "[*",
  "[/",
  "]*",
  "]/",
  "]]",
  "[{",
  "]}",
  "g,",
  "g;",
}

for k in pairs(remapList) do
  keymap("n", remapList[k], remapList[k] .. "zz", opts)
  keymap("v", remapList[k], remapList[k] .. "zz", opts)
end

keymap("t", "<C-h>", "<C-\\><C-n><C-w>h")
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j")
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k")
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l")

keymap("i", "jk", "<esc>")
-- Add undo break-points

keymap("i", ",", ",<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", ";", ";<c-g>u")

-- Better indent
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP')

-- Move Lines

keymap("v", "K", ":m '<-2<CR>gv=gv")
keymap("v", "J", ":m '>+1<CR>gv=gv")

-- Resize window using <shift> arrow keys
keymap("n", "<S-Up>", "<cmd>resize +2<CR>")
keymap("n", "<S-Down>", "<cmd>resize -2<CR>")
keymap("n", "<S-Left>", "<cmd>vertical resize -2<CR>")
keymap("n", "<S-Right>", "<cmd>vertical resize +2<CR>")

keymap("n", "]q", "<cmd>cnext<CR>", { desc = "Next Quickfix" })
keymap("n", "[q", "<cmd>cprev<CR>", { desc = "Previous Quickfix" })
keymap("n", "J", "mzJ`z")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "<Leader>wt", [[:%s/\s\+$//e<cr>]])
keymap("x", "<leader>p", [["_dP]])

keymap({ "n", "v" }, "<leader>y", [["+y]])
keymap("n", "<leader>Y", [["+Y]])
keymap("n", "Q", "<nop>")
-- shut all the way up
keymap("n", "ZZ", "<cmd>wqall <CR>")
keymap("n", "<M-x>", "<cmd>!chmod +x %<CR>", { silent = true })
keymap("n", "<leader>w", "<cmd>w <CR>")
keymap("n", "<leader>wa", "<cmd>wa <CR>")
keymap("n", "<leader>sv", ":source $MYVIMRC<CR>", { silent = true })
keymap("n", "<C-a>", "ggVG")

-- Navigate autocompletions in command window
keymap("c", "<C-j>", "<C-n>", opts)
keymap("c", "<C-k>", "<C-p>", opts)

keymap("n", "<leader>ms", function()
  local snippet_dir = vim.fn.stdpath("config") .. "/snippets"
  vim.cmd("source " .. snippet_dir .. "/*")
end, { desc = "Reload snippets" })
