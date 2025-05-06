return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1001,

	opts = {
		flavour = "mocha",
		term_colors = true,
		integrations = {
			blink_cmp = true,
			fidget = true,
			snacks = true,
			which_key = true,
		},
	},
	config = function()
		vim.cmd.colorscheme("catppuccin")
	end,
}
