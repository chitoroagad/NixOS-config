return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				lua = { "luacheck" },
				python = { "ruff" },
				javascript = { "biomejs" },
				typescript = { "biomejs" },
				json = { "biomejs" },
				sh = { "shellcheck" },
				c = { "cpplint" },
				dockerfile = { "hadolint" },
			}

			lint.linters.luacheck = {
				cmd = "luacheck",
				stdin = true,
				args = {
					"--globals",
					"vim",
					"lvim",
					"reload",
					"--",
				},
				stream = "stdout",
				ignore_exitcode = true,
				parser = require("lint.parser").from_errorformat("%f:%l:%c: %m", {
					source = "luacheck",
				}),
			}

			-- Auto command to actually lint
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					if vim.opt_local.modifiable:get() then
						lint.try_lint()
					end
				end,
			})
		end,
	},
}
