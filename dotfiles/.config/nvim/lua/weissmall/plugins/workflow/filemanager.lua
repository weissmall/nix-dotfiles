local function harpoon_telescope(harpoon_files)
  local conf = require("telescope.config").values
  local file_paths = {}
  for _, item in pairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
      .new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      })
      :find()
end

---@module 'lazy'
---@type LazySpec[]
return {
  {
    "echasnovski/mini.files",
    lazy = true,
    ---@type LazyKeysSpec[]
    keys = {
      {
        "<leader>fm",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true, {})
        end,
        desc = "[F]ile[M]anager",
      },
      {
        "<leader>fM",
        function()
          require("mini.files").open(vim.uv.cwd(), true, {})
        end,
        desc = "[F]ile[M]anager (cwd)",
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "s1n7ax/nvim-window-picker",
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    lazy = false, -- neo-tree will lazily load itself
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
      enable_diagnostics = true,
      enable_git_status = true,
      enable_modified_markers = true,
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
      },
    },
    ---@type LazyKeysSpec[]
    keys = {
      {
        "<leader>ft",
        "<cmd>Neotree<cr>",
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function(_)
      local function get_visual_selection()
        local vstart = vim.fn.getpos("'<") -- Get start position of visual selection
        local vend = vim.fn.getpos("'>") -- Get end position of visual selection

        -- Extract line numbers and column numbers
        local s_line, s_col = vstart[2], vstart[3]
        local e_line, e_col = vend[2], vend[3]

        -- Get lines within the selection
        local lines = vim.api.nvim_buf_get_lines(0, s_line - 1, e_line, false)

        -- Adjust for character-wise selection within lines
        if #lines == 1 then
          -- Single line selection
          return string.sub(lines[1], s_col, e_col)
        else
          -- Multi-line selection
          lines[1] = string.sub(lines[1], s_col)
          lines[#lines] = string.sub(lines[#lines], 1, e_col)
          return table.concat(lines, "\n")
        end
      end

      local harpoon = require("harpoon")
      harpoon:setup({})

      vim.keymap.set("n", "<leader>ea", function()
        harpoon:list():add()
      end)
      vim.keymap.set("n", "<leader>ed", function()
        harpoon:list():remove()
      end)
      vim.keymap.set("n", "<leader>el", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
      vim.keymap.set("n", "<leader>en", function()
        harpoon:list():next()
      end)
      vim.keymap.set("n", "<leader>ep", function()
        harpoon:list():prev()
      end)
      vim.keymap.set("n", "<leader>ee", function()
        harpoon_telescope(harpoon:list())
      end)
      vim.keymap.set("v", "<leader>ed", function()
        local selected = get_visual_selection()
        vim.notify(selected)
      end)
    end,
  },
}
