local root_dir_lua = function(bufnr, cb)
	local root = vim.fs.root(bufnr, {
		"luarc.json",
		".luarc.json",
		".git",
	}) or vim.fn.expand("%:p:h")
	cb(root)
end

return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_dir = root_dir_lua,
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace", -- neodev.nvim completion
				showWord = "Disable", -- disable word suggestion of lsp
			},
			diagnostics = {
				globals = { "vim", "Snacks" }, -- recognize 'vim' global to language server
				undefined_global = false,
			},
			workspace = {
				ignoreDir = { ".git" },
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					vim.api.nvim_get_runtime_file('lua',true),

					-- `lazydev` imports vim.env.VIMRUNTIME automatically in `library` field.
					-- so you don't need to set in `library` field with `lazydev`
					-- it loads libraries which is what you declared in lua file using `require()` function when it detects.
					-- it is very convenient to write neovim lua plugins.
					-- plus, If you add source 'lazydev' in nvim-cmp, it suggests the installed plugin names in `require()`
				},
			},
		},
	},
}
