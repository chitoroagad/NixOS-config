return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "catppuccin",
			section_separators = { left = "", right = "" },
			component_separators = "|",
		},
		sections = {
			lualine_a = {
				{ "mode" },
			},
			lualine_b = {
				{ "filename", padding = { left = 1 } },
			},
			lualine_c = { "branch", "diff", "diagnostics" },
			lualine_x = { { "filetype", icon_only = true }, "lsp_status" },
		},

		-- tabline = {
		-- 	lualine_a = { "buffers" },
		-- }
		extensions = {
			"fzf",
			"lazy",
			"man",
			"neo-tree",
			"quickfix",
			"nvim-dap-ui"
		},
	},
}
