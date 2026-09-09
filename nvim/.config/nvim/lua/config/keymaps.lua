local map = vim.keymap.set

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Window navigation
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus left" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus right" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus down" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus up" })

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local buf = { buffer = event.buf }
		map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", buf, { desc = "Go to definition" }))
		map("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", buf, { desc = "Go to declaration" }))
		map("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", buf, { desc = "Go to implementation" }))
		map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", buf, { desc = "Go to references" }))
		map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", buf, { desc = "Hover documentation" }))
		map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", buf, { desc = "Rename symbol" }))
		map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", buf, { desc = "Code action" }))
		-- Formatting is handled by conform.nvim (<leader>gf) with lsp fallback.
		-- Do not add a separate vim.lsp.buf.format binding here.
	end,
})
