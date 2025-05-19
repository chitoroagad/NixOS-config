return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	ft = { "markdown", "quarto" },
	keys = { "<leader>tm", "<cmd>RenderMarkdown toggle<cr>", desc = "[T]oggle Render[m]arkdown" },
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		completions = {
			lsp = { enabled = true },
			blink = { enabled = true },
		},
		-- render_modes = true,
		render_modes = { "n", "c", "t" },
	},
}
