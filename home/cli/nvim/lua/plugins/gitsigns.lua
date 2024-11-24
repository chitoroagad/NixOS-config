return {
	"lewis6991/gitsigns.nvim",
	lazy = false,
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "󰍵" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "│" },
			},
		})
	end,
	on_attach = function(bufnr)
		vim.keymap.set(
			"n",
			"<leader>hp",
			require("gitsigns").preview_hunk,
			{ buffer = bufnr, desc = "Preview git hunk" }
		)
	end,
}
