local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.disable_default_key_bindings = true
config.color_scheme = "Gruvbox Dark (Gogh)"
config.front_end = "OpenGL"
config.animation_fps = 1
config.cursor_blink_rate = 350
config.default_cursor_style = "BlinkingBlock"
config.hide_mouse_cursor_when_typing = true
config.tiling_desktop_environments = {
	"X11 i3",
	"X11 dwm",
}
config.window_decorations = "NONE"
config.default_prog = { "fish" }
config.enable_scroll_bar = false
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
-- config.term = "wezterm"
config.warn_about_missing_glyphs = false
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
