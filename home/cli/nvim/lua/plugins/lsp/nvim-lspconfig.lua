local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.icons").diagnostic_signs
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"folke/neovim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"windwp/nvim-autopairs",
		"j-hui/fidget.nvim",
		"nvim-java/nvim-java",
	},
	config = function()
		require("neoconf").setup({})
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local lspconfig = require("lspconfig")
		local capabilities = cmp_nvim_lsp.default_capabilities()

		for type, icon in pairs(diagnostic_signs) do
			local hl = "Diagnostic_Signs" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- LUA
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							vim.fn.expand("$VIMRUNTIME/lua"),
							vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/lua",
						},
					},
				},
			},
		})

		-- JSON
		lspconfig.jsonls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "json", "jsonc" },
		})

		-- PYTHON
		lspconfig.pyright.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				pyright = {
					-- disableOrganizeImports = false,
					analysis = {
						useLibraryCodeForTypes = true,
						autoSearchPaths = true,
						diagnosticMode = "workspace",
						autoImportCompletions = true,
					},
				},
			},
		})

		lspconfig.ruff.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- BASH
		lspconfig.bashls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "sh", "aliasrc", "zsh" },
		})

		-- DOCKER
		lspconfig.dockerls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- C/C++
		lspconfig.clangd.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = {
				"clangd",
				"--offset-encoding=utf-16",
			},
		})

		-- TYPESCRIPT
		lspconfig.ts_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = {
				"javascript",
				"typescript",
				"typescriptreact",
			},
			root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
			cmd = {
				"typescript-language-server",
				"--stdio",
			},
		})

		-- WEBDEV EXTRA
		lspconfig.emmet_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = {
				"javascriptreact",
				"css",
				"sass",
				"scss",
				"less",
				"html",
			},
		})

		-- Text
		lspconfig.ltex.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = {
				"text",
				"txt",
				"markdown",
			},
		})

		-- Nix
		lspconfig.nil_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- GLSL
		lspconfig.glsl_analyzer.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- Java
		lspconfig.jdtls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end,
}
