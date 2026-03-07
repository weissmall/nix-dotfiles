---@module 'lazy'
---@type LazySpec
return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufWritePre" },
  init = function(_)
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({ bufnr = args.buf })
      end,
    })
  end,
  opts = {
    -- [Formatters list](https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters)
    -- :h conform-formatters
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      rust = { "rustfmt" },
      dart = { "dart_format" },
      sql = { "pg_format" },
      -- c = { "clangformat" },
      -- cpp = { "clangformat" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
