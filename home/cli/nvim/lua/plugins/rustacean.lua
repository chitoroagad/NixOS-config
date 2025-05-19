return {
	"mrcjkb/rustaceanvim",
	version = "^6",
	lazy = false,
	config = function()
		vim.g.rustaceanvim = {
			tools = {
				test_executor = "background",
				code_actions = { ui_select_fallback = true },
			},

			server = {
				on_attach = function(client, bufnr)
					vim.keymap.set({ "n", "v" }, "gra", function()
						if vim.api.nvim_get_mode().mode == "n" then
							vim.api.nvim_feedkeys("V", "t", true)
						end
						vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
					end, { silent = true, buffer = bufnr })
					-- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
					vim.keymap.set("n", "K", function()
						vim.cmd.RustLsp({ "hover", "actions" })
					end, { silent = true, buffer = bufnr })

					vim.keymap.set("n", "<leader>de", function()
						vim.cmd.RustLsp({ "explainError", "current" })
					end, { silent = true, buffer = bufnr, desc = "[E]xplain [E]rror" })

					-- Override Neovim's built-in line join with smart join line
					vim.keymap.set({ "n", "v" }, "J", function()
						vim.cmd.RustLsp("joinLines")
					end, { silent = true, buffer = bufnr })
				end,
			},
		}
	end,
}
