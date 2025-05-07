local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set -- Center Text on the Screen {{{
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
-- disabling these as they can be annoying
-- keymap("n", "<M-j>", ":m .+1<CR>==")
-- keymap("n", "<M-k>", ":m .-2<CR>==")
-- keymap("i", "<M-j>", "<Esc>:m .+1<CR>==gi")
-- keymap("i", "<M-k>", "<Esc>:m .-2<CR>==gi")

-- Resize window using <shift> arrow keys
keymap("n", "<S-Up>", "<cmd>resize +2<CR>")
keymap("n", "<S-Down>", "<cmd>resize -2<CR>")
keymap("n", "<S-Left>", "<cmd>vertical resize -2<CR>")
keymap("n", "<S-Right>", "<cmd>vertical resize +2<CR>")

vim.api.nvim_set_keymap("n", "]]", "<cmd>cnext<CR>", { desc = "Next Quickfix", noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[[", "<cmd>cprev<CR>", { desc = "Previous Quickfix", noremap = true, silent = true })
keymap("n", "J", "mzJ`z")
keymap("n", "J", "mzJ`z")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "<Leader>wt", [[:%s/\s\+$//e<cr>]])
-- keymap("n", "<leader>wq", ":update<CR>:quit<CR>")
-- greatest remap ever
keymap("x", "<leader>p", [["_dP]])

keymap({ "n", "v" }, "<leader>y", [["+y]])
keymap("n", "<leader>Y", [["+Y]])

-- keymap({ "n", "v" }, "<leader>d", [["_d]])

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

keymap("n", "<leader>ms", "<cmd>source ~/.config/nvim/snippets/*<cr>", { desc = "Reload snippets" })
