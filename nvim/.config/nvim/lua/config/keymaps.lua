local map = vim.keymap.set

map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('n', '<C-/>', ':split | term<CR>', { desc = 'Open terminal in split' })


vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }
    map('n', 'gd', vim.lsp.buf.definition, opts)
    map('n', 'gD', vim.lsp.buf.declaration, opts)
    map('n', 'gi', vim.lsp.buf.implementation, opts)
    map('n', 'gr', vim.lsp.buf.references, opts)
    map('n', 'K', vim.lsp.buf.hover, opts)
    map('n', '<leader>rn', vim.lsp.buf.rename, opts)
    map({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    -- Formatting is handled by conform.nvim (<leader>gf) with lsp fallback.
    -- Do not add a separate vim.lsp.buf.format binding here.
  end,
})
