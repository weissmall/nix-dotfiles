-- [ToggleTerm] terminal management
local Terminal = require("toggleterm.terminal").Terminal
local defaultTerminal = Terminal:new({
	direction = "float",
	highlights = {
		Normal = {
			guibg = "",
		},
		NormalFloat = {
			link = "Normal",
		},
		FloatBorder = {
			guifg = "",
			guibg = "",
		},
	},
	autochdir = false,
	start_in_insert = false,
	auto_scroll = true,
	winbar = {
		enabled = false,
	},
})
local function toggleDefaultTerminal()
	defaultTerminal:toggle()
end

local terminalEscape = [[<C-\><C-n>]]
local terminalSelect = "<Cmd>TermSelect<CR>"

-- [Bufferline] buffers management
local bufferline = require("bufferline")
local bufdelete = require("bufdelete")
local function deleteCurrentBuffer()
	bufdelete.bufdelete(0, true)
end

local bufferCycleNext = function()
	bufferline.cycle(1)
end

local bufferCyclePrev = function()
	bufferline.cycle(-1)
end

local M = {
	toggleTerminal = toggleDefaultTerminal,
	term = {
		toggle = toggleDefaultTerminal,
		select = terminalSelect,
		escape = terminalEscape,
	},
	bufferline = {
		next = bufferCycleNext,
		prev = bufferCyclePrev,
		delCur = deleteCurrentBuffer,
	},
}

-- Buffer management
vim.keymap.set("n", "<A-l>", M.bufferline.next, { desc = "Cycle next buffer" })
vim.keymap.set("n", "<A-h>", M.bufferline.prev, { desc = "Cycle prev buffer" })
vim.keymap.set("n", "<A-c>", M.bufferline.delCur, { desc = "[C]lose current buffer" })

-- NeoTerm terminal management
vim.keymap.set("n", "tt", M.toggleTerminal, { desc = "[T]oggle [T]erminal" })
vim.keymap.set("t", "<esc>", M.term.escape, { desc = "[Esc]ape terminal mode" })
vim.keymap.set("n", "<leader>ts", M.term.select, { desc = "[T]erminal [S]elect" })
