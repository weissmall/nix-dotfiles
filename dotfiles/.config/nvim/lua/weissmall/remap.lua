local _ = { noremap = true, silent = true }

-- Setting leader key for Space
vim.g.mapleader = " "

-- Setting <leader> + p + v to call `Ex` command in normal mode
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>lsi", vim.cmd.Mason)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m .-2<CR>gv=gv")

vim.keymap.set("n", "<C-s>", vim.cmd.w)
vim.keymap.set("n", "<leader>s", vim.cmd.w)

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')

-- Close
vim.keymap.set("n", "<leader>q", vim.cmd.q)
vim.keymap.set("n", "<leader>wq", vim.cmd.q)
vim.keymap.set("n", "<leader>qa", vim.cmd.qa)
vim.keymap.set("n", "<leader>wqa", vim.cmd.wqa)

-- Buffers motions from `barbar` extension
-- vim.keymap.set("n", "<A-l>", "<Cmd>BufferNext<CR>", opts)
-- vim.keymap.set("n", "<A-h>", "<Cmd>BufferPrevious<CR>", opts)
--
-- vim.keymap.set("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
-- vim.keymap.set("n", "<A-e>", "<Cmd>BufferPick<CR>", opts)
-- vim.keymap.set("n", "<A-Right>", "<Cmd>BufferNext<CR>", opts)
-- vim.keymap.set("n", "<A-Left>", "<Cmd>BufferPrevious<CR>", opts)
--

-- Transparency
vim.keymap.set("n", "<leader>tt", vim.cmd.TransparentToggle)

-- Resizing
-- Useful link: https://vi.stackexchange.com/questions/514/how-do-i-change-the-current-splits-width-and-height
-- Horizontal
vim.keymap.set("n", "<Right>", "1<C-w><")
vim.keymap.set("n", "<Left>", "1<C-w>>")

-- Vertical
vim.keymap.set("n", "<Up>", "1<C-w>+")
vim.keymap.set("n", "<Down>", "1<C-w>-")

-- vim.keymap.set("n", "<leader>j", "<C-w>j")
-- vim.keymap.set("n", "<leader>k", "<C-w>k")
-- vim.keymap.set("n", "<leader>h", "<C-w>h")
-- vim.keymap.set("n", "<leader>l", "<C-w>l")

vim.keymap.set("n", "<leader>K", vim.diagnostic.open_float)
vim.keymap.set("v", "<leader>x", ":lua<CR>")

-- vim.keymap.set("n", "<leader>wrs", vim.g.wrap_state_set, {})
vim.keymap.set("n", "<leader>nft", function()
	vim.notify(vim.bo.filetype)
end)
