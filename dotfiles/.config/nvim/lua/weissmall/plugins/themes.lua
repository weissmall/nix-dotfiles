---@module 'lazy'
---@type LazySpec
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = true,
  },
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    priority = 1000,
    lazy = true,
    ---@module 'tokyonight'
    ---@type tokyonight.Config
    opts = {
      transparent = true,
      style = "night",
      on_highlights = function(hl, c)
        hl.TelescopeNormal = {
          fg = c.fg_dark,
        }
        -- hl.TelescopeBorder = {
        --   fg = c.bg_dark,
        -- }
      end,
    },
  },
  {
    "tiagovla/tokyodark.nvim",
    name = "tokyodark",
    priority = 1000,
    lazy = true,
  },
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    priority = 1000,
    lazy = true,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
  },
  {
    "shaunsingh/nord.nvim",
    name = "nord",
    lazy = true,
  },
  {
    "cranberry-clockworks/coal.nvim",
    name = "coal",
    lazy = true,
  },
}
