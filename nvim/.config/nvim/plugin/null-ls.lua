local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

-- none-ls.nvim is unmaintained and still reads this table from its old
-- location; Neovim 0.11's LSP client rewrite moved it under lsp.protocol,
-- so without this shim any attach crashes in null-ls/client.lua.
vim.lsp._request_name_to_capability = vim.lsp.protocol._request_name_to_capability

-- Formatting is handled by conform.nvim; this is diagnostics-only.
null_ls.setup({
	sources = {
		require("none-ls.diagnostics.eslint_d"),
	},
})
