return {
	"folke/which-key.nvim",
	event = "VimEnter",
	opts = {
		delay = 5,
		icons = {
			mappings = vim.g.have_nerd_font,
		},

		-- Document existing key chains
		spec = {
			{ "<leader>s",  group = "[S]earch" },
			{ "gr",         group = "LSP" },
			{ "<leader>t",  group = "[T]oggle" },
			{ "<leader>d",  group = "[D]ebug" },
			{ "<leader>ds", group = "[D]ebug: [S]tep" },
			{ "<leader>h",  group = "Git [H]unk",     mode = { "n", "v" } },
		},
	},
}
