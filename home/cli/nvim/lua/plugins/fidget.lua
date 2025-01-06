return {
	"j-hui/fidget.nvim",
	tag = "v1.5.0",
	lazy = false,
	priority = 998,
	opts = {
		progress = {
			display = {
				render_limit = 6,
				skip_history = false,
				priority = 0,
			},
			ignore = { "ltex" },
		},
		notification = {
			history_size = 200,
			override_vim_notify = true,
			window = {
				winblend = 0,
			},
		},
	},
}
