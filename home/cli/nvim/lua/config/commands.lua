vim.api.nvim_create_user_command("LspRestart", function()
	vim.lsp.stop_client(vim.lsp.get_clients())
	vim.cmd("edit")
end, {})


vim.api.nvim_create_user_command("LspStop", function()
	vim.lsp.stop_client(vim.lsp.get_clients())
end, {})
