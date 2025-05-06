--- GLOBALS ---
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

--- SETTINGS ---
local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.schedule(function()
-- 	opt.clipboard = "unnamedplus"
-- end)

opt.breakindent = true
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live.
opt.inccommand = "split"

opt.cursorline = true
opt.scrolloff = 10
opt.confirm = false

-- Tab / Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.smartindent = true
opt.wrap = false

-- Search
opt.incsearch = true
opt.hlsearch = false

-- Apperance
opt.termguicolors = true
opt.colorcolumn = "100"
opt.cmdheight = 1
opt.completeopt = "menuone,noinsert,noselect"

-- Behaviour
opt.hidden = true
opt.errorbells = false
opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.backspace = "indent,eol,start"
opt.autochdir = false
