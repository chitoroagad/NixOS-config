local function bin(name)
	local p = vim.fn.exepath(name)
	return p ~= "" and p or nil
end

return {
	"chomosuke/typst-preview.nvim",
	ft = "typst",
	version = "1.*",
	opts = {
		dependencies_bin = {
			["tinymist"] = bin("tinymist"),
			["websocat"] = bin("websocat"),
		},
	},
}
