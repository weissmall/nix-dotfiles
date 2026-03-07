---@class W_options
---@field paths string[] The paths that contains the directories you want to switch into.
---@field git_repos boolean false if you do not want to include the git repositories from your HOME dir in the directories to switch into.
---@field show "base" | "full" Wether to show directories base or full name.
---@field binding W_options_binding

---@class W_options_binding
---@field key string The key to press.
---@field mods string The modifiers to use.

local wezterm = require("wezterm")
local wpr = wezterm.plugin.require("https://github.com/vieitesss/workspacesionizer.wezterm")

---@type W_options
local defaultOpts = {
  paths = {
    "~/Projects",
    "~/Projects/Dipal/",
    "~/Projects/Dipal/Kaiser/",
  },
  git_repos = true,
  show = "base",
  binding = {
    key = "o",
    mods = "ALT",
  },
}

---@param config any
---@param opts W_options?
local function apply(config, opts)
  ---@type W_options
  local finalOpts = opts or defaultOpts
  wpr.apply_to_config(config, finalOpts)
end

return {
  apply = apply,
}
