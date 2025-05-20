vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Runs when LSP attaches to any buffer",
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		local capabilites = require("blink.cmp").get_lsp_capabilities()

		client.capabilities = vim.tbl_deep_extend("force", {}, capabilites, client.capabilities or {})

		local function map(keys, func, desc, mode)
			mode = mode or "n"
			desc = "LSP: " .. desc
			vim.keymap.set(mode, keys, func, { buffer = args.buf, desc = desc })
		end

		-- Mappings
		map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
		map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
		--  To jump back, press <C-t>.
		map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
		map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		-- Fuzzy find all the symbols in your current document.
		map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
		-- Fuzzy find all the symbols in your current workspace.
		map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
		-- Jump to the type of the word under your cursor.
		map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

		-- Highlights word under cursor
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, args.buf) then
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = args.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			-- Unhighlight word under cursor when move
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = args.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			-- Remove hightlight group when Lsp detaches
			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		-- Toggle inlay hints
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, args.buf) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }))
			end, "[T]oggle Inlay [H]ints")
		end

		-- Check for folding capabilities
		if client:supports_method('textDocument/foldingRange') then
			local win = vim.api.nvim_get_current_win()
			vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
			vim.wo[win][0].foldtext = "v:lua.vim.lsp.foldtext()"
		end
	end,
})
