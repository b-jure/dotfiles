local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config:set_strict_mode(true)

require("settings").setup(wezterm, config)
require("keybinds").setup(wezterm, config)
require("events").setup(wezterm)

return config
