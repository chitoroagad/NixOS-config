vim.lsp.config["clangd"] = {
	cmd = { "clangd", "--offset-encoding=utf-16" },
	filetypes = { "c", "cpp", "h", "hpp" },
}
