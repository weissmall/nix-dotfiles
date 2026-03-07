local project = require("project_nvim")

project.setup({
	active = true,
	on_config_done = nil,
	manual_mode = false,
	detection_methods = {
		"pattern",
	},
	patterns = {
		".git",
		"pubspec.yaml",
		"Cargo.toml",
		".nvimproj",
	},
	show_hidden = true,
	scope_chdir = "global",
	silent_chdir = true,
})
