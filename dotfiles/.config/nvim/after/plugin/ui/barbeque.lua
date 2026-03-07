local barbeque = require("barbecue")
local barbequeUI = require("barbecue.ui")

vim.keymap.set("n", "<leader>bb", barbequeUI.toggle)

barbeque.setup({
	theme = "tokyonight-night",
	show_basename = true,
	show_navic = false,
})
