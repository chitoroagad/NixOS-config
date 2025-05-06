vim.keymap.set(
	"n",
	"<Esc>",
	"<cmd>nohlsearch<CR>",
	{ desc = "Clear highlights on search when pressing <Esc> in normal mode" }
)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Identing
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Misc
vim.keymap.set("n", "<leader>dm", ":delm!<CR>", { desc = "[D]elete All [M]arks" })
vim.keymap.set("n", "<leader>C", function() vim.api.nvim_buf_get_name(0) end, { desc = "[C]urrent path" })
