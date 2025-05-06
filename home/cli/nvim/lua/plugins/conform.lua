vim.g.disable_autoformat = true

return { -- Autoformat
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format" },
			javascript = { "biome" },
			typescript = { "biome" },
			javascriptreact = { "biome" },
			typescriptreact = { "biome" },
			css = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			sh = { "shfmt" },
			c = { "clang_format" },
			rust = { "rustfmt" },
			markdown = { "prettierd", "prettier", stop_after_first = true },
			yaml = { "prettierd", "prettier", stop_after_first = true },
			nix = { "alejandra" },
		},

		format_on_save = function(bufnr)
			-- Disable with a global or buffer-local variable
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { timeout_ms = 500, lsp_format = "fallback" }
		end,
	},

	config = function()
		-- Create command to temporarily format on save
		vim.api.nvim_create_user_command("FormatEnable", function(args)
			if args.bang then
				-- FormatEnable! will enable formatting for just this buffer
				vim.b.disable_autoformat = false
			else
				vim.g.disable_autoformat = false
			end
		end, {
			desc = "Enable autoformat",
			bang = true,
		})

		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				-- FormatDisable! will disable formatting just for this buffer
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat",
			bang = true,
		})

		-- Toggle global autoformat
		vim.keymap.set("n", "<leader>tf", function()
			vim.g.disable_autoformat = not vim.g.disable_autoformat
			local state = vim.g.disable_autoformat and "Disabled" or "Enabled"
			print("Global autoformat: " .. state)
		end, { desc = "[T]oggle auto[f]ormat" })

		-- Toggle buffer-local autoformat
		vim.keymap.set("n", "<leader>tF", function()
			vim.b.disable_autoformat = not vim.b.disable_autoformat
			local state = vim.b.disable_autoformat and "Disabled" or "Enabled"
			print("Buffer autoformat: " .. state)
		end, { desc = "[T]oggle buffer-local auto[F]ormat" })
	end,
}
