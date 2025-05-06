return {
	cmd = { "pyright" },
	filetypes = { "python" },
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
}
