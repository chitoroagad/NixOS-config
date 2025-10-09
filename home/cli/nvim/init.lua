require("config.lazy")

-- Default LSP config
vim.lsp.config["*"] = {
	root_markers = { ".git" },
}

vim.lsp.enable({
	"bashls",
	"clangd",
	"dockerls",
	"emmetls",
	"fishls",
	"jsonls",
	"ltexls-plus",
	"luals",
	"nil",
	"pyrefly",
	"ruff",
	"tinymist",
	"tsls",
})
