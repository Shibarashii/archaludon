-- Global tab settings
vim.opt.tabstop = 2       -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 2    -- Size of an indent
vim.opt.expandtab = true  -- Use spaces instead of tabs
vim.opt.softtabstop = 2   -- Number of spaces a <Tab> feels like when editing
vim.opt.number = true

-- Optional: Auto-indent
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Vim Diagnostic
vim.diagnostic.config({
  virtual_text = { severity = vim.diagnostic.severity.ERROR },
  virtual_lines = { current_line = true }, -- only show for the line your cursor is on
})


