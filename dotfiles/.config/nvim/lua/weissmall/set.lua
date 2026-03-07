vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Configs for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.timeout = true
vim.o.timeoutlen = 500
-- vim.cmd([[
--   set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz,хъ;[],ХЪ;{},жэ;\;',ЖЭ;:\",/;\|,б;.,Б;<,ю;.,Ю;>
-- ]])
vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Wrapping
vim.opt.wrap = false
vim.opt.laststatus = 3

-- vim.opt.guicursor = ""
