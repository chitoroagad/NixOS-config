local is_latex = function()
	return vim.bo.filetype == "tex" or vim.bo.filetype == "latex"
end

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
}
