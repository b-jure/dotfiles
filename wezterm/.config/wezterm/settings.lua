local M = {}

function M.setup(wezterm, config)
    -- remove default key binds
    config.disable_default_key_bindings = true

    -- increase scrollback line limit
    config.scrollback_lines = 10000

    -- enable hot reload
    config.automatically_reload_config = true

    -- do not ask for confirmation when exiting
    config.window_close_confirmation = "NeverPrompt"

    -- layout and theme
    config.color_scheme = "Gruvbox Dark (Gogh)"
    config.front_end = "OpenGL"
    config.animation_fps = 1
    config.cursor_blink_rate = 0
    config.default_cursor_style = "SteadyBlock"
    config.hide_mouse_cursor_when_typing = true
    config.window_decorations = "TITLE | RESIZE"
    config.enable_scroll_bar = false

    -- tab bar
    config.enable_tab_bar = true
    config.hide_tab_bar_if_only_one_tab = false
    config.tab_bar_at_bottom = true
    config.use_fancy_tab_bar = false
    config.tab_and_split_indices_are_zero_based = true
    config.colors = {}
    config.colors.tab_bar = {
        -- color of the tab bar
        background = "#282828",
        -- the active tab is the one that has focus in the window
        active_tab = {
            bg_color = "#fe8019",
            fg_color = "#1d2021",
            -- intensity can be "Half", "Normal" or "Bold"
            intensity = "Bold",
            -- underline can be "None", "Single" or "Double"
            underline = "None",
            italic = false,
            strikethrough = false
        },
        -- inactive tabs are the tabs that do not have focus
        inactive_tab = {
            bg_color = "#1d2021",
            fg_color = "#fbf1c7",
            intensity = "Normal",
            underline = "None",
            italic = false,
            strikethrough = false
        },
        new_tab = {
            bg_color = "#282828",
            fg_color = "#83c07c",
        },
    }

    -- window manager
    config.tiling_desktop_environments = {
        "X11 i3",
        "X11 dwm",
    }

    -- shell
    config.default_prog = { "fish" }

    -- font
    config.font_size = 10
    config.warn_about_missing_glyphs = false
    config.font = wezterm.font_with_fallback({
        { family = "Iosevka", weight = "Regular" },
        { family = "Berkeley Mono", weight = "Regular" },
        { family = "FiraCode Nerd Font Ret", weight = "Regular" },
    })

    -- disable ligatures
    config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

    -- multiplexing
    config.unix_domains = {
        {
            name = "unix",
        },
    }
end

return M
