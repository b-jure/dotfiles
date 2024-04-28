local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.automatically_reload_config = true

-- debug
-- config.debug_key_events = true

config.disable_default_key_bindings = true

-- colorscheme
config.color_scheme = "Gruvbox Dark (Gogh)"

-- renderer
config.front_end = "OpenGL"

-- disable animations
config.animation_fps = 1

-- cursor settings
config.cursor_blink_rate = 350
config.default_cursor_style = "BlinkingBlock"
config.hide_mouse_cursor_when_typing = true

-- tiling wm's
config.tiling_desktop_environments = {
	"X11 i3",
	"X11 dwm",
}

-- window decorations
config.window_decorations = "NONE"

-- shell program
config.default_prog = { "fish" }

-- disable bars
config.enable_scroll_bar = false
config.enable_tab_bar = false

-- set TERM var
config.term = "wezterm"

-- do not send notification
config.warn_about_missing_glyphs = false

-- fonts
config.font = wezterm.font_with_fallback({
	{ family = "Iosevka Custom", weight = "Medium" },
	{ family = "FiraCode Nerd Font" },
	{ family = "Berkeley Mono", weight = "Regular" },
	{ family = "NotoSansM Nerd Font" },
	{ family = "PragmataPro" },
	{ family = "DejaVu Sans" },
	{ family = "DejaVu Sans Mono" },
	{ family = "DejaVuSansM Nerd Font Mono" },
	{ family = "Symbols Nerd Font" },
	{ family = "Symbols Nerd Font Mono" },
})
config.font_size = 14

return config
