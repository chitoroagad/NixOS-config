return {
	"folke/snacks.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		image = {
			enabled = true,
			force = true,
		},
		zen = {
			enabled = true,
			toggles = { dim = false, git_signs = true },
		},

		styles = { zen = { backdrop = { transparent = false } } },
	},

	keys = {
		{
			"<leader>tz",
			function()
				Snacks.zen()
			end,
			desc = "[T]oggle [Z]en",
		},
	},
}
