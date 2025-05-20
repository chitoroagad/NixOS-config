return {
	{
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
						-- vim.keymap.set({ "n", "v" }, "gra", function()
						-- 	vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
						-- end, { silent = true, buffer = bufnr })

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
	},

	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		opts = {
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},

			completion = {
				crates = {
					enabled = true, -- disabled by default
					max_results = 8, -- The maximum number of search results to display
					min_chars = 3, -- The minimum number of charaters to type before completions begin appearing
				},
			},
		},
	},
}
