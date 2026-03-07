local term = require("toggleterm")
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

term.setup({
  shade_terminals = false,
  shade_filetypes = false,
  persist_size = true,
})

local job_id = 0
vim.keymap.set("n", "<leader>ot", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 10)
  job_id = vim.bo.channel
end, {})

local function close_term()
  vim.fn.chansend(job_id, { "" })
end

vim.keymap.set("n", "<leader>ct", close_term)

return {
  terminal = defaultTerminal,
}
