-- Autocomplete stuff
return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"L3MON4D3/LuaSnip",
		"folke/lazydev.nvim",
	},
	build = "nix run .#build-plugin",

	--- @module 'blink.cmp'
	--- @type blink.cmp.Config
	opts = {
		signature = { enabled = true },
		snippets = { preset = "luasnip" },
		sources = {
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority (see `:h blink.cmp`)
					score_offset = 100,
				},
			},
		},

		completion = {
			keyword = { range = "full" },
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
			},
		},
	},
}
