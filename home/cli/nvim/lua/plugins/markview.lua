local is_latex = function()
	return vim.bo.filetype == "tex" or vim.bo.filetype == "latex"
end

return {
	{
		"OXY2DEV/markview.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
			"saghen/blink.cmp",
		},
		lazy = false,
		priority = 49,
		config = function()
			require("markview").setup({
				preview = {
					icons = "devicons",
					modes = { "i", "n", "no", "c" },
					hybrid_modes = { "i", "n" },
					linewise_hybrid_mode = true,
					debounce = 1,
				},
				latex = {
					enable = is_latex(),
				},
				typst = {
					enable = false,
				},
				markdown = {
					list_items = {
						shift_width = function(buffer, item)
							--- Reduces the `indent` by 1 level.
							---
							---         indent                      1
							--- ------------------------- = 1 ÷ --------- = new_indent
							--- indent * (1 / new_indent)       new_indent
							---
							local parent_indnet = math.max(1, item.indent - vim.bo[buffer].shiftwidth)

							return item.indent * (1 / (parent_indnet * 2))
						end,
						marker_minus = {
							add_padding = function(_, item)
								return item.indent > 1
							end,
						},
					},
				},
			})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = function()
			require("lazy").load({ plugins = { "markdown-preview.nvim" } })
			vim.fn["mkdp#util#install"]()
		end,
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		keys = {
			{
				"<leader>tm",
				ft = "markdown",
				"<cmd>MarkdownPreviewToggle<cr>",
				desc = "[T]oggle [M]arkdown Preview",
			},
		},
		config = function()
			vim.cmd([[do FileType]])
		end,
	},
}
