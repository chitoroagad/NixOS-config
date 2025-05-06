return {
	{ "folke/which-key.nvim", lazy = true },
	"tpope/vim-sleuth", -- detect tabstop and shiftwidth automatically
	{
		"folke/todo-comments.nvim",
		event = "BufEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}
