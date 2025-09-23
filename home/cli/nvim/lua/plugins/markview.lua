return {
	"OXY2DEV/markview.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
		"saghen/blink.cmp",
	},
	lazy = false,
	priority = 49,
	config = function()
		local presets = require("markview.presets").headings
		require("markview").setup({
			preview = {
				icons = "devicons",
				modes = { "i", "n", "no", "c" },
				hybrid_modes = { "i" },
				linewise_hybrid_mode = true,
			},
			latex = {
				blocks = {
					pad_amount = 1,
				},
			},
			markdown = {
				headings = presets.glow,
			},
		})
	end,
}
