-- set default values for all lsp configs
vim.lsp.config["*"] = {}

-- load all configs in this dir
local dir = vim.fn.getcwd() .. "/lua/config/lsp"
local globp = dir .. "/*.lua"

-- find all files in current dir
local files = vim.fn.glob(globp, false, true)

local names = {}

-- store file names without path or extension (unless init file)
for _, filepath in ipairs(files) do
	local name = vim.fn.fnamemodify(filepath, ":t:r")
	if name ~= "init" then
		table.insert(names, name)
	end
end

-- call files, then enable lsp
for _, name in ipairs(names) do
	require("config.lsp." .. name)
	vim.lsp.enable(name)
end
