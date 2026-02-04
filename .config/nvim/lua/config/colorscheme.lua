-- Function to remove backgrounds for transparency
local function remove_backgrounds()
  local groups = {
    "BufferLine",
    "Comment",
    "Conditional",
    "Constant",
    "CursorLine",
    "CursorLineNr",
    "EndOfBuffer",
    "Function",
    "FidgetTitle",
    "FidgetTask",
    "Identifier",
    "LineNr",
    "NonText",
    "Normal",
    "NormalFloat",
    "NormalNC",
    "NormalSB",
    "Operator",
    "PreProc",
    "Repeat",
    "SignColumn",
    "Special",
    "Statement",
    "StatusLine",
    "StatusLineNC",
    "String",
    "Structure",
    "TelescopeNormal",
    "Todo",
    "Type",
    "Underlined",
  }

  for _, v in ipairs(groups) do
    local ok, prev_attrs = pcall(vim.api.nvim_get_hl_by_name, v, true)
    if ok and (prev_attrs.background or prev_attrs.bg or prev_attrs.ctermbg) then
      local attrs = vim.tbl_extend("force", prev_attrs, { bg = "NONE", ctermbg = "NONE" })
      attrs[true] = nil
      vim.api.nvim_set_hl(0, v, attrs)
    end
  end
end

-- Load colorscheme
pcall(vim.cmd, "colorscheme gruvbox")

-- Apply transparency immediately after colorscheme loads
vim.schedule(function()
  remove_backgrounds()
  -- Custom highlight groups
  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
end)

-- Also reapply on ColorScheme event (when changing colorschemes)
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.schedule(remove_backgrounds)
  end,
})
