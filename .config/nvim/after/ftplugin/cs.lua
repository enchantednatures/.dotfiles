-- C# specific settings
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.textwidth = 120
vim.opt_local.wrap = false

-- Better folding for C# classes and methods
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt_local.foldlevel = 99

-- Enable case-insensitive search for C# (common pattern)
vim.opt_local.ignorecase = true
vim.opt_local.smartcase = true

-- Enable C# comment format options
vim.opt_local.formatoptions:append "r" -- Auto-insert comment leader on <CR>
vim.opt_local.formatoptions:append "o" -- Auto-insert comment leader on 'o' or 'O'
vim.opt_local.formatoptions:append "q" -- Allow formatting of comments with gq
vim.opt_local.formatoptions:append "c" -- Auto-wrap comments using textwidth

-- C# specific keymaps for better navigation
local opts = { buffer = true, silent = true }

-- Quick navigation to methods and classes
vim.keymap.set(
  "n",
  "]m",
  "/\\v^\\s*(public|private|protected|internal).*\\{<CR>",
  vim.tbl_extend("force", opts, { desc = "Next method" })
)
vim.keymap.set(
  "n",
  "[m",
  "?\\v^\\s*(public|private|protected|internal).*\\{<CR>",
  vim.tbl_extend("force", opts, { desc = "Previous method" })
)
vim.keymap.set(
  "n",
  "]c",
  "/\\v^\\s*(public|internal)\\s+(class|interface|enum|struct)<CR>",
  vim.tbl_extend("force", opts, { desc = "Next class" })
)
vim.keymap.set(
  "n",
  "[c",
  "?\\v^\\s*(public|internal)\\s+(class|interface|enum|struct)<CR>",
  vim.tbl_extend("force", opts, { desc = "Previous class" })
)

-- Quick test running shortcuts
vim.keymap.set(
  "n",
  "<leader>tt",
  function() require("neotest").run.run() end,
  vim.tbl_extend("force", opts, { desc = "Run test under cursor" })
)

vim.keymap.set(
  "n",
  "<leader>tf",
  function() require("neotest").run.run(vim.fn.expand "%") end,
  vim.tbl_extend("force", opts, { desc = "Run tests in file" })
)

vim.keymap.set(
  "n",
  "<leader>td",
  function() require("neotest").run.run { strategy = "dap" } end,
  vim.tbl_extend("force", opts, { desc = "Debug test under cursor" })
)

vim.api.nvim_create_autocmd({ "InsertLeave", "LspAttach", "BufReadPre", "BufWritePost" }, {
  pattern = "*",
  callback = function()
    local clients = vim.lsp.get_clients { name = "roslyn" }
    if not clients or #clients == 0 then return end

    for buf, _ in pairs(clients[1].attached_buffers) do
      if vim.lsp.util._refresh then
        vim.lsp.util._refresh("textDocument/diagnostic", { bufnr = buf })
      end
    end
  end,
})

vim.api.nvim_create_user_command("CSFixUsings", function()
  local bufnr = vim.api.nvim_get_current_buf()

  local clients = vim.lsp.get_clients { name = "roslyn" }
  if not clients or vim.tbl_isempty(clients) then
    vim.notify("Couldn't find client", vim.log.levels.ERROR, { title = "Roslyn" })
    return
  end

  local client = clients[1]
  local action = {
    kind = "quickfix",
    data = {
      CustomTags = { "RemoveUnnecessaryImports" },
      TextDocument = { uri = vim.uri_from_bufnr(bufnr) },
      CodeActionPath = { "Remove unnecessary usings" },
      Range = {
        ["start"] = { line = 0, character = 0 },
        ["end"] = { line = 0, character = 0 },
      },
      UniqueIdentifier = "Remove unnecessary usings",
    },
  }

  client:request("codeAction/resolve", action, function(err, resolved_action)
    if err then
      vim.notify("Fix using directives failed", vim.log.levels.ERROR, { title = "Roslyn" })
      return
    end
    vim.lsp.util.apply_workspace_edit(resolved_action.edit, client.offset_encoding)
  end)
end, { desc = "Remove unnecessary using directives" })
-- Add compiler

vim.api.nvim_create_autocmd({ "InsertLeave", "LspAttach", "BufReadPre", "BufWritePost" }, {
  callback = function(args)
    local clients = vim.lsp.get_clients { name = "roslyn" }
    if not clients or #clients == 0 then return end
    if vim.lsp.codelens.enable then
      vim.lsp.codelens.enable(true, { bufnr = args.buf })
    else
      vim.lsp.codelens.refresh({ bufnr = args.buf })
    end
  end,
})

-- Auto-format and organize imports on save
local cs_group = vim.api.nvim_create_augroup("CSharpIDE", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = cs_group,
  pattern = "*.cs",
  callback = function()
    -- Format document
    vim.lsp.buf.format { async = false }

    -- Remove unnecessary usings
    pcall(function() vim.cmd "CSFixUsings" end)
  end,
})

-- Quick refactoring helpers
vim.keymap.set("v", "<leader>re", function()
  vim.lsp.buf.code_action {
    filter = function(action) return action.title:match "Extract" or action.title:match "Refactor" end,
  }
end, vim.tbl_extend("force", opts, { desc = "Extract/Refactor selection" }))

vim.cmd "compiler! dotnet"
