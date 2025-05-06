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
	"jsonls",
	"ltexls",
	"luals",
	"nil",
	"pyright",
	"ruff",
	"tsls",
})
