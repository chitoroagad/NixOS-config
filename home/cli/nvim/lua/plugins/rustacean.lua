local set = vim.keymap.set

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local opts = { noremap = true, silent = true, buffer = bufnr }
		if client and client.name == "rust-analyzer" then
			opts.desc = "Show docs"
			set("n", "K", vim.cmd.RustLsp({ "hover", "actions" }))

			opts.desc = "Explain Error"
			set("n", "<leader>ee", vim.cmd.RustLsp("explainError"))

			opts.desc = "Join Lines"
			set("n", "<leader>J", vim.cmd.RustLsp("joinLines"))

			opts.desc = "Code actions"
			set("n", "<leader>ca", vim.cmd.RustLsp("codeAction"), opts) -- see available code actions

			opts.desc = "Jump to definition"
			set("n", "<leader>gd", vim.lsp.buf.definition, opts) -- peak definition

			opts.desc = "Jump to declaration"
			set("n", "<leader>gD", vim.lsp.buf.declaration, opts) -- go to definition

			opts.desc = "Show implementations"
			set("n", "<leader>gi", vim.lsp.buf.implementation, opts) -- go to implementation

			opts.desc = "Smart rename"
			set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show line diagnostics in float window"
			set("n", "<leader>dl", vim.diagnostic.open_float, opts) -- show  diagnostics for buffer

			opts.desc = "Show all diagnostics in telescope"
			set("n", "<leader>dt", "<cmd>Telescope diagnostics<CR>", opts) -- show  diagnostics for buffer

			opts.desc = "Jump to next diagnostic in buffer"
			set("n", "<leader>dn", vim.diagnostic.goto_next, opts) -- show diagnostics for line

			opts.desc = "Jump to prev diagnostic in buffer"
			set("n", "<leader>dp", vim.diagnostic.goto_prev, opts) -- jump to prev diagnostic in buffer
		end
	end,
})

return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	lazy = false,
}
