require("weissmall.set")
require("weissmall.remap")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Colorize ANSI text
  {
    "m00qek/baleia.nvim",
    conf = false,
  },
  { import = "weissmall.plugins" },
  { import = "weissmall.plugins.core" },
  { import = "weissmall.plugins.core.languages" },
  { import = "weissmall.plugins.utils" },
  { import = "weissmall.plugins.workflow" },
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "famiu/bufdelete.nvim",
    },
  },
  -- { "gelguy/wilder.nvim" },
  -- {
  -- 	"folke/noice.nvim",
  -- 	-- event = "VeryLazy",
  -- 	opts = {},
  -- 	dependencies = {
  -- 		"MunifTanjim/nui.nvim",
  -- 		"rcarriga/nvim-notify",
  -- 	},
  -- },
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({})
    end,
  },
  -- Rofi syntax
  {
    "Fymyte/rasi.vim",
    ft = { "rasi" },
    lazy = true,
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
    enabled = false,
    opts = {
      rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
    },
  },
  -- {
  -- 	"rest-nvim/rest.nvim",
  -- 	ft = "http",
  -- 	dependencies = { "luarocks.nvim" },
  -- 	config = function()
  -- 		require("rest-nvim").setup()
  -- 	end,
  -- },
  {
    "Joakker/lua-json5",
    build = "./install.sh",
  },
  {
    "Everduin94/nvim-quick-switcher",
  },
  -- Tests
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "sidlatau/neotest-dart",
      "marilari88/neotest-vitest",
    },
    lazy = true,
  },
  -- Plugin for firefox
  -- {
  -- 	"glacambre/firenvim",
  -- 	lazy = not vim.g.started_by_firenvim,
  -- 	build = function()
  -- 		vim.fn["firenvim#install"](0)
  -- 	end,
  -- 	lazy = true,
  -- },
  -- { "github/copilot.vim", deactivate = true },
  -- {
  -- 	"Civitasv/cmake-tools.nvim",
  -- 	branch = "main",
  -- 	opts = {
  -- 		cmake_build_directory = "build",
  -- 		cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
  -- 	},
  -- },
  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
  },
  -- Debugging

  { "jay-babu/mason-nvim-dap.nvim" },
  { "MunifTanjim/prettier.nvim" },
  { "vidocqh/auto-indent.nvim" },
  -- { "abecodes/tabout.nvim" },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}, -- this is equalent to setup({}) function
  },
  -- Detect tabstop and shiftwidth automatically
  {
    "tpope/vim-sleuth",
    lazy = true,
  },

  { "xiyaowong/transparent.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "allaman/emoji.nvim",
    version = "1.0.0", -- optionally pin to a tag
    ft = "markdown",   -- adjust to your needs
    dependencies = {
      -- util for handling paths
      "nvim-lua/plenary.nvim",
      -- -- optional for nvim-cmp integration
      -- "hrsh7th/nvim-cmp",
      -- optional for telescope integration
      "nvim-telescope/telescope.nvim",
      -- -- optional for fzf-lua integration via vim.ui.select
      -- "ibhagwan/fzf-lua",
    },
    opts = {
      -- default is false, also needed for blink.cmp integration!
      enable_cmp_integration = false,
      -- optional if your plugin installation directory
      -- is not vim.fn.stdpath("data") .. "/lazy/
      -- plugin_path = vim.fn.expand("$HOME/plugins/"),
    },
    config = function(_, opts)
      require("emoji").setup(opts)
      -- optional for telescope integration
      local ts = require('telescope').load_extension 'emoji'
      vim.keymap.set('n', '<leader>se', ts.emoji, { desc = '[S]earch [E]moji' })
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build =
    "cmake -S. -Bbuild -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
  },
  {
    url = "https://codeberg.org/elfahor/telescope-just.nvim",
    requires = {
      "nvim-telescope/telescope.nvim",
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    "nvim-treesitter/playground",
    lazy = true,
  },
  -- "theprimeagen/harpoon",
  {
    "mbbill/undotree",
    lazy = true,
  },

  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },

  { "VonHeikemen/lsp-zero.nvim",        branch = "v3.x" },
  { "neovim/nvim-lspconfig" },
  -- { "hrsh7th/cmp-nvim-lsp" },
  -- { "hrsh7th/cmp-nvim-lua" },
  -- { "hrsh7th/cmp-path" },
  -- { "hrsh7th/nvim-cmp" },
  {
    "L3MON4D3/LuaSnip",
    enabled = false,
    dependencies = {
      "rafamadriz/friendly-snippets",
      "benfowler/telescope-luasnip.nvim",
      "saadparwaiz1/cmp_luasnip",
    },
    version = "v2.*",
    build = "make install_jsregexp",
  },
  -- Powerline
  { "nvim-lualine/lualine.nvim" },

  -- Neovim development
  -- { "folke/neodev.nvim",        opts = {} },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta",     lazy = true }, -- optional `vim.uv` typings
  {                                            -- optional completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    enabled = false,
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      -- table.insert(opts.sources, {
      -- 	name = "lazydev",
      -- 	group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      -- })
    end,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
  },

  -- Rust
  -- {
  -- 	"mrcjkb/rustaceanvim",
  -- 	version = "^3", -- Recommended
  -- 	ft = { "rust" },
  -- },
  -- Project management
  { "ahmedkhalf/project.nvim" },

  -- Startup dashboard
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    cmd = "Telescope projects",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- Barbecue (breadcrumbs like line)
  {
    "utilyre/barbecue.nvim",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- Opened windows bar
  -- {
  -- 	"romgrk/barbar.nvim",
  -- 	dependencies = {
  -- 		"lewis6991/gitsigns.nvim",
  -- 		"nvim-tree/nvim-web-devicons",
  -- 	},
  -- 	init = function()
  -- 		vim.g.barbar_auto_setup = false
  -- 	end,
  -- 	version = "*",
  -- },

  -- Notifications
  -- { "rcarriga/nvim-notify" },

  -- Golang
  {
    "olexsmir/gopher.nvim",
    lazy = true,
  },

  -- Formatting
  { "mhartington/formatter.nvim", cond = false },

  -- VimBeGood
  ---@type LazySpec
  {
    "ThePrimeagen/vim-be-good",
    lazy = true,
    cmd = "VimBeGood",
  },

  -- Python envs
  {
    "AckslD/swenv.nvim",
    lazy = true,
  },

  -- UI Hooks
  { "stevearc/dressing.nvim" },

  -- Which key
  { "folke/which-key.nvim" },

  -- Startup time
  {
    "dstein64/vim-startuptime",
    lazy = true,
    cmd = "StartupTime",
  },
})
