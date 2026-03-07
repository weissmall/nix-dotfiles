-- Taken from nvim/runtime/lua/vim/lsp/buf.lua

local api = vim.api
local lsp = vim.lsp
local util = require("vim.lsp.util")

---@param method string
---@param opts? vim.lsp.LocationOpts
local function get_location(method, params, opts)
  opts = opts or {}
  params = params or {}
  local bufnr = api.nvim_get_current_buf()
  local clients = lsp.get_clients({ method = method, bufnr = bufnr })
  if not next(clients) then
    vim.notify(lsp._unsupported_method(method), vim.log.levels.WARN)
    return
  end
  local win = api.nvim_get_current_win()
  local from = vim.fn.getpos(".")
  from[1] = bufnr
  local tagname = vim.fn.expand("<cword>")
  local remaining = #clients

  ---@type vim.quickfix.entry[]
  local all_items = {}

  ---@param result nil|lsp.Location|lsp.Location[]
  ---@param client vim.lsp.Client
  local function on_response(_, result, client)
    local locations = {}
    if result then
      locations = vim.islist(result) and result or { result }
    end
    local items = util.locations_to_items(locations, client.offset_encoding)
    vim.list_extend(all_items, items)
    remaining = remaining - 1
    if remaining == 0 then
      if vim.tbl_isempty(all_items) then
        vim.notify("No locations found", vim.log.levels.INFO)
        return
      end

      local title = "LSP locations"
      if opts.on_list then
        assert(vim.is_callable(opts.on_list), "on_list is not a function")
        opts.on_list({
          title = title,
          items = all_items,
          context = { bufnr = bufnr, method = method },
        })
        return
      end

      if #all_items == 1 then
        local item = all_items[1]
        local b = item.bufnr or vim.fn.bufadd(item.filename)

        -- Save position in jumplist
        vim.cmd("normal! m'")
        -- Push a new item into tagstack
        local tagstack = { { tagname = tagname, from = from } }
        vim.fn.settagstack(vim.fn.win_getid(win), { items = tagstack }, "t")

        vim.bo[b].buflisted = true
        local w = win
        if opts.reuse_win then
          w = vim.fn.win_findbuf(b)[1] or w
          if w ~= win then
            api.nvim_set_current_win(w)
          end
        end
        api.nvim_win_set_buf(w, b)
        api.nvim_win_set_cursor(w, { item.lnum, item.col - 1 })
        vim._with({ win = w }, function()
          -- Open folds under the cursor
          vim.cmd("normal! zv")
        end)
        return
      end
      if opts.loclist then
        vim.fn.setloclist(0, {}, " ", { title = title, items = all_items })
        vim.cmd.lopen()
      else
        vim.fn.setqflist({}, " ", { title = title, items = all_items })
        vim.cmd("botright copen")
      end
    end
  end
  for _, client in ipairs(clients) do
    local lparams = util.make_position_params(win, client.offset_encoding)
    for k, v in pairs(params) do
      lparams[k] = v
    end
    client:request(method, lparams, function(_, result)
      on_response(_, result, client)
    end)
  end
end

local util = require("lspconfig/util")

vim.keymap.set("n", "<leader>lsr", vim.cmd.LspRestart)

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  -- Prettier section
  -- local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
  -- local event = "BufWritePre" -- or "BufWritePost"
  -- if client.supports_method("textDocument/formatting") then
  -- 	vim.keymap.set("n", "<Leader>f", function()
  -- 		vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
  -- 	end, { buffer = bufnr, desc = "[lsp] format" })
  --
  -- 	-- format on save
  -- 	vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
  -- 	vim.api.nvim_create_autocmd(event, {
  -- 		buffer = bufnr,
  -- 		group = group,
  -- 		callback = function()
  -- 			vim.lsp.buf.format({ bufnr = bufnr, async = true })
  -- 		end,
  -- 		desc = "[lsp] format on save",
  -- 	})
  -- end
  -- if client.supports_method("textDocument/rangeFormatting") then
  -- 	vim.keymap.set("x", "<Leader>f", function()
  -- 		vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
  -- 	end, { buffer = bufnr, desc = "[lsp] format" })
  -- end
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  -- local nmap = function(keys, func, desc)
  -- 	if desc then
  -- 		desc = "LSP: " .. desc
  -- 	end
  --
  -- 	vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  -- end
  --
  -- nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  -- nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
  --
  -- nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
  -- nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  -- nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
  -- nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
  -- nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  -- nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
  --
  -- -- See `:help K` for why this keymap
  -- nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  -- nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
  --
  -- -- Lesser used LSP functionality
  -- nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  -- nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  -- nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  -- nmap("<leader>wl", function()
  -- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, "[W]orkspace [L]ist Folders")
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("mason").setup({})
local mason_lsp = require("mason-lspconfig")

local function bindKeys(bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
  nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  -- Diagnostic
  nmap("dn", vim.diagnostic.goto_next, "[D]iagnostic [N]ext")
  nmap("dp", vim.diagnostic.goto_prev, "[D]iagnostic [P]revious")
end

local function buffer_format(bufnr)
  local group = "lsp_autoformat"
  vim.api.nvim_create_augroup(group, { clear = false })
  vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    group = group,
    desc = "LSP format on save",
    callback = function()
      -- note: do not enable async formatting
      vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
      -- vim.notify(tostring(group))
    end,
  })

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP Actions",
  callback = function(event)
    local opts = {
      buffer = event.buf,
    }
    local id = vim.tbl_get(event, "data", "client_id")
    local client = id and vim.lsp.get_client_by_id(id)
    if client == nil then
      return
    end

    -- Setup autoformat
    if client.supports_method("textDocument/formatting") then
      buffer_format(event.buf)
    end

    -- Setup keybinds
    bindKeys(opts.buffer)
  end,
})

mason_lsp.setup({
  ensure_installed = {
    "lua_ls",
  },
  sources = {
    "nvim_lsp",
    "luasnip",
  },
  automatic_enable = false,
  handlers = {},
})

-- local cmp = require("cmp")
-- local compare = require("cmp.config.compare")

-- cmp.setup({
-- 	sources = cmp.config.sources({
-- 		{
-- 			name = "nvim_lsp",
-- 		},
-- 		{
-- 			name = "luasnip",
-- 		},
-- 		{
-- 			name = "lazydev",
-- 			group_index = 0,
-- 		},
-- 	}),
-- 	-- :help cmp-config.sorting.comparators
-- 	sorting = {
-- 		priority_weight = 1.0,
-- 		comparators = {
-- 			function(t1, t2)
-- 				return compare.kind(t1, t2)
-- 			end,
-- 			compare.order,
-- 			compare.exact,
-- 		},
-- 	},
-- 	snippet = {
-- 		expand = function(args)
-- 			require("luasnip").lsp_expand(args.body)
-- 		end,
-- 	},
-- 	mapping = cmp.mapping.preset.insert({
-- 		["<Tab>"] = cmp.mapping.confirm({ select = true }),
-- 		["<Esc>"] = cmp.mapping.abort(),
-- 		["<C-l>"] = cmp.mapping.confirm({ select = true }),
-- 		["<C-h>"] = cmp.mapping.abort(),
-- 		["<C-j>"] = cmp.mapping.select_next_item({ behavior = "insert" }),
-- 		["<C-k>"] = cmp.mapping.select_prev_item({ behavior = "insert" }),
-- 		["<C-Space>"] = cmp.mapping.complete(),
-- 	}),
-- })

local lspConfig = require("lspconfig")

lspConfig.lua_ls.setup({
  n_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        },
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
        -- library = vim.api.nvim_get_runtime_file("", true)
      },
    })
  end,
  root_dir = util.root_pattern(
    "init.lua",
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git"
  ),
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = {
          "vim",
          "require",
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- vim.api.nvim_get_runtime_file("", true),
          -- vim.fn.expand("$VIMRUNTIME/lua"),
          -- vim.fn.expand("$HOME/.local/share/nvim"),
        },
      },
      telemetry = {
        enable = false,
      },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
})

lspConfig.eslint.setup({
  settings = {
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = "separateLine",
      },
      showDocumentation = {
        enable = true,
      },
    },
    codeActionOnSave = {
      enable = false,
      mode = "all",
    },
    experimental = {
      useFlatConfig = false,
    },
    format = true,
    nodePath = "",
    onIgnoredFiles = "off",
    problems = {
      shortenToSingleLine = false,
    },
    quiet = false,
    rulesCustomizations = {},
    run = "onType",
    useESLintClass = false,
    validate = "on",
    workingDirectory = {
      mode = "location",
    },
  },
})

lspConfig.rust_analyzer.setup({
  on_attach = function(client)
    require("completion").on_attach(client)
  end,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        features = {
          "client",
          "server",
        },
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
})

lspConfig.gopls.setup({
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "go.mod" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  -- settings = {
  -- 	gopls = {
  -- 		analyses = {
  -- 			unusedparams = true,
  -- 			shadow = true,
  -- 		},
  -- 		staticcheck = true,
  -- 	},
  -- },
})
-- https://microsoft.github.io/pyright/#/settings
lspConfig.pyright.setup({
  capabilities = capabilities,
  python = {
    analysis = {
      autoSearchPaths = true,
      diagnosticMode = "workspace",
    },
  },
})

lspConfig.clangd.setup({
  capabilities = vim.tbl_extend("keep", capabilities, {
    offsetEncoding = { "utf-8", "utf-16" },
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
  }),
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
    semanticHighlighting = true,
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  single_file_support = true,
  root_markers = {
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    ".git",
  },
  root_dir = util.root_pattern(
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    ".git"
  ),
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
  },
})

-- lspConfig.dcmls.setup({
-- 	cmd = {
-- 		"dcm",
-- 		"start-server",
-- 		"--client=neovim",
-- 	},
-- 	filetypes = {
-- 		"dart",
-- 	},
-- 	root_dir = util.root_pattern("pubspec.yaml"),
-- })

-- lspConfig.dartls.setup({
-- 	cmd = { "dart", "language-server", "--protocol=lsp" },
-- 	filetypes = { "dart" },
-- 	init_options = {
-- 		closingLabels = true,
-- 		flutterOutline = true,
-- 		onlyAnalyzeProjectsWithOpenFiles = true,
-- 		outline = true,
-- 		suggestFromUnimportedLibraries = true,
-- 	},
-- 	root_dir = util.root_pattern("pubspec.yaml"),
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- 	settings = {
-- 		dart = {
-- 			showTodos = true,
-- 			completeFunctionCalls = true,
-- 			enableSnippets = true,
-- 			updateImportsOnRename = true,
-- 		},
-- 		flutter = {
-- 			showTodos = true,
-- 			completeFunctionCalls = true,
-- 			enableSnippets = true,
-- 			updateImportsOnRename = true,
-- 		},
-- 	},
-- })

lspConfig.cmake.setup({
  cmd = { "cmake-language-server" },
  filetypes = { "cmake" },
  init_options = "build",
  root_dir = util.root_pattern("CmakePresets.json", ".git", "build", "cmake", "CMakeLists.txt"),
  single_file_support = true,
})

lspConfig.gdscript.setup({
  filetypes = {
    "gd",
    "gdscript",
    "gdscript3",
  },
  root_dir = util.root_pattern("project.godot", ".git"),
})

lspConfig.terraformls.setup({
  cmd = { "terraform-ls", "serve" },
  filetypes = { "terraform", "terraform-vars", "tf" },
  root_markers = { ".terraform", ".git" },
})

lspConfig.ts_ls.setup({
  on_attach = function(client, bufnr)
    require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
  end,
  filetypes = {
    "javascript",
    "typescript",
    "typescriptreact",
  },
})

lspConfig.cssls.setup({
  filetypes = { "css", "scss", "less" },
  init_options = {
    -- provideFormatter = false,
  },
  settings = {
    css = {
      validate = true,
    },
    less = {
      validate = true,
    },
    scss = {
      validate = true,
    },
  },
})

-- lspConfig.svelte.setup({
--   cmd = {
--     "svelteserver",
--     "--stdio",
--   },
--   filetypes = { "svelte" },
--   root_dir = util.root_pattern("package.json"),
-- })

lspConfig.jsonls.setup({
  capabilities = capabilities,
})

-- lspConfig.yamlls.setup({
-- 	settings = {
-- 		redhat = {
-- 			telemetry = {
-- 				enabled = false,
-- 			},
-- 		},
-- 		yaml = {
-- 			schemas = {
-- 				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
-- 			},
-- 		},
-- 	},
-- })

lspConfig.docker_compose_language_service.setup({
  cmd = { "docker-compose-langserver", "--stdio" },
  filetypes = { "yaml.docker-compose", "yml.docker-compose", "yaml" },
  root_dir = util.root_pattern("docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml"),
  single_file_support = true,
})

lspConfig.dockerls.setup({
  settings = {
    docker = {
      languageserver = {
        formatter = {
          ignoreMultilineInstructions = true,
        },
      },
    },
  },
  cmd = { "docker-langserver", "--stdio" },
  filetypes = { "dockerfile" },
  root_dir = util.root_pattern("Dockerfile"),
  single_file_support = true,
})

lspConfig.groovyls.setup({
  -- 	cmd = { "java", "-jar", "groovy-language-server-all.jar" },
  filetypes = { "groovy" },
  single_file_support = true,
})

lspConfig.kotlin_language_server.setup({
  filetypes = "kotlin",
  capabilities = capabilities,
})

-- lspConfig.postgres_lsp.setup({
-- 	capabilities = capabilities,
-- 	filetypes = { "sql" },
-- })

lspConfig.qmlls.setup({
  capabilities = capabilities,
  cmd = { "qmlls", "-E" }
})

-- lspConfig.ccls.setup {
--   init_options = {
--     cache = {
--       directory = ".ccls-cache",
--     },
--   },
--   on_attach = function(client, bufnr)
--     local opts = { buffer = bufnr, remap = false }
--     local lopts = { loclist = true }
--     -- ...
--     vim.keymap.set('n', 'gxb', function() get_location('$ccls/inheritance', {}, lopts) end, opts)
--     vim.keymap.set('n', 'gxB', function() get_location('$ccls/inheritance', { levels = 3 }, lopts) end, opts)
--     vim.keymap.set('n', 'gxd', function() get_location('$ccls/inheritance', { derived = true }, lopts) end, opts)
--     vim.keymap.set('n', 'gxD', function() get_location('$ccls/inheritance', { derived = true, levels = 3 }, lopts) end,
--       opts)
--     vim.keymap.set('n', 'gxc', function() get_location('$ccls/call', {}, lopts) end, opts)
--     vim.keymap.set('n', 'gxC', function() get_location('$ccls/call', { callee = true }, lopts) end, opts)
--     vim.keymap.set('n', 'gxs', function() get_location('$ccls/member', { kind = 2 }, lopts) end, opts)
--     vim.keymap.set('n', 'gxf', function() get_location('$ccls/member', { kind = 3 }, lopts) end, opts)
--     vim.keymap.set('n', 'gxm', function() get_location('$ccls/member', {}, lopts) end, opts)
--     vim.keymap.set('n', '<C-j>', function() get_location('$ccls/navigate', { direction = 'D' }, lopts) end, opts)
--     vim.keymap.set('n', '<C-k>', function() get_location('$ccls/navigate', { direction = 'U' }, lopts) end, opts)
--     vim.keymap.set('n', '<C-h>', function() get_location('$ccls/navigate', { direction = 'L' }, lopts) end, opts)
--     vim.keymap.set('n', '<C-l>', function() get_location('$ccls/navigate', { direction = 'R' }, lopts) end, opts)
--   end,
-- }

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

vim.diagnostic.config({
  float = {
    source = true,
    border = "rounded",
  },
})
