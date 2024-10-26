local M = {}

function M.setup(wezterm, config)
    local act = wezterm.action

    -- Leader key
    config.leader =
        { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }

    -- Keybinds
    config.keys = {
        {
            key = "r",
            mods = "LEADER",
            action = act.ActivateKeyTable({
                name = "resize_pane",
                one_shot = false,
            }),
        },
        {
            key = "a",
            mods = "LEADER",
            action = act.ActivateKeyTable({
                name = "activate_pane",
                timeout_milliseconds = 1000,
            }),
        },
        {
            key = "c",
            mods = "LEADER",
            action = act.SpawnTab("CurrentPaneDomain"),
        },
        {
            key = "x",
            mods = "LEADER",
            action = act.CloseCurrentPane({ confirm = true }),
        },
        { key = "b", mods = "LEADER", action = act.ActivateTabRelative(-1) },
        { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
        {
            key = "\\",
            mods = "LEADER",
            action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
        },
        {
            key = "-",
            mods = "LEADER",
            action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
        },
        { key = "0", mods = "CTRL", action = act.ResetFontSize },
        { key = "=", mods = "CTRL", action = act.IncreaseFontSize },
        { key = "-", mods = "CTRL", action = act.DecreaseFontSize },
    }

    for i = 0, 9 do
        table.insert(config.keys, {
            key = tostring(i),
            mods = "LEADER",
            action = act.ActivateTab(i),
        })
    end

    -- Key tables
    config.key_tables = {
        resize_pane = {
            { key = "j", action = act.AdjustPaneSize({ "Left", 5 }) },
            { key = ";", action = act.AdjustPaneSize({ "Right", 5 }) },
            { key = "l", action = act.AdjustPaneSize({ "Up", 5 }) },
            { key = "k", action = act.AdjustPaneSize({ "Down", 5 }) },
            { key = "Escape", action = "PopKeyTable" },
        },
        activate_pane = {
            { key = "j", action = act.ActivatePaneDirection("Left") },
            { key = ";", action = act.ActivatePaneDirection("Right") },
            { key = "l", action = act.ActivatePaneDirection("Up") },
            { key = "k", action = act.ActivatePaneDirection("Down") },
        },
    }
end

return M
