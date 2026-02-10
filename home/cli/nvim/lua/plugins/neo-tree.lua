return {
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neo-tree/neo-tree.nvim",
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			"antosha417/nvim-lsp-file-operations",
			{
				"s1n7ax/nvim-window-picker", -- for open_with_window_picker keymaps
				version = "2.*",
				config = function()
					require("window-picker").setup({
						filter_rules = {
							include_current_win = false,
							autoselect_one = true,
							-- filter using buffer options
							bo = {
								-- if the file type is one of following, the window will be ignored
								filetype = { "neo-tree", "neo-tree-popup", "notify" },
								-- if the buffer type is one of following, the window will be ignored
								buftype = { "terminal", "quickfix" },
							},
						},
					})
				end,
			},
		},

		cmd = "Neotree",
		keys = {
			{ "<leader>n", ":Neotree toggle reveal right<CR>", desc = "[N]eoTree reveal", silent = true },
		},
		---@module "neo-tree"
		---@type neotree.Config?
		opts = {
			close_if_last_window = true,
			-- popup_border_style = "none",
			source_selector = {
				statusline = true,
				content_layout = "center",
				tabs_layout = "focus",
			},
			filesystem = {
				filtered_items = {
					hide_by_name = { "node-modules" },
					always_show = { ".gitignored" },
				},
				window = {
					mappings = {
						["<leader>n"] = "close_window",
					},
				},
			},
		},
	},
}
