---@module 'lazy'
---@type LazySpec[]
return {
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    ---@type LazyKeysSpec[]
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xe",
        "<cmd>Trouble diagnostics filter.severity=vim.diagnostic.severity.ERROR<cr>",
        desc = "Diagnostics [E]rrors",
      },
    },
  },
  {
    "artemave/workspace-diagnostics.nvim",
  },
}
