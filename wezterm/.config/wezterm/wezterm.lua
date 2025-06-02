local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
    config:set_strict_mode(true)
end

require("settings").setup(wezterm, config)
require("keybinds").setup(wezterm, config)
require("events").setup(wezterm)
require("plugin").setup(wezterm, config)

return config
