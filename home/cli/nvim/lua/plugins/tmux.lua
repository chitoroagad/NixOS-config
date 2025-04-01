return {
	"aserowy/tmux.nvim",
	lazy = false,
	config = function()
		require("tmux").setup({
			copy_sync = { sync_clipboard = false },
		})
	end,
}
