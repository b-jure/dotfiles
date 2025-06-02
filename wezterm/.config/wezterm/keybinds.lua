local M = {}

function M.setup(wezterm, config)
  local act = wezterm.action

  local function close_copy_mode()
    return act.Multiple({
      act.CopyMode("ClearSelectionMode"),
      act.CopyMode("ClearPattern"),
      act.CopyMode("MoveToScrollbackBottom"),
      act.CopyMode("Close"),
    })
  end

  local function finish_close(activate)
    return wezterm.action_callback(function(window, pane, _)
      if activate then
        window:perform_action(act.ActivateCopyMode, pane)
        window:perform_action(act.CopyMode("ClearPattern"), pane)
        window:perform_action(act.CopyMode("ClearSelectionMode"), pane)
      end
    end)
  end

  -- Leader key
  config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }
  -- Keybinds
  config.keys = {
    { key = "n", mods = "ALT|SHIFT", action = act.MoveTabRelative(-1) },
    { key = "m", mods = "ALT|SHIFT", action = act.MoveTabRelative(1) },
    {
      key = "8",
      mods = "CTRL",
      action = wezterm.action.PaneSelect,
    },
    {
      key = "9",
      mods = "CTRL",
      action = wezterm.action.PaneSelect({
        mode = "SwapWithActive",
      }),
    },
    {
      key = "f",
      mods = "LEADER",
      action = wezterm.action.ToggleFullScreen,
    },
    {
      key = "r",
      mods = "LEADER",
      action = act.ActivateKeyTable({
        name = "resize_pane",
        one_shot = false,
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
    { key = "p", mods = "ALT", action = act.ActivateTabRelative(-1) },
    { key = "n", mods = "ALT", action = act.ActivateTabRelative(1) },
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
    { key = "[", mods = "LEADER", action = act.ActivateCopyMode },
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
    search_mode = {
      {
        key = "Enter",
        mods = "NONE",
        action = act.CopyMode("PriorMatch"),
      },
      {
        key = "Escape",
        mods = "NONE",
        action = finish_close(1),
      },
      { key = "n", mods = "CTRL", action = act.CopyMode("NextMatch") },
      { key = "p", mods = "CTRL", action = act.CopyMode("PriorMatch") },
      {
        key = "r",
        mods = "CTRL",
        action = act.CopyMode("CycleMatchType"),
      },
      { key = "w", mods = "CTRL", action = act.CopyMode("ClearPattern") },
      {
        key = "PageUp",
        mods = "NONE",
        action = act.CopyMode("PriorMatchPage"),
      },
      {
        key = "PageDown",
        mods = "NONE",
        action = act.CopyMode("NextMatchPage"),
      },
      {
        key = "UpArrow",
        mods = "NONE",
        action = act.CopyMode("PriorMatch"),
      },
      {
        key = "DownArrow",
        mods = "NONE",
        action = act.CopyMode("NextMatch"),
      },
    },
    copy_mode = {
      {
        key = "/",
        mods = "NONE",
        action = act.Search({ CaseSensitiveString = "" }),
      },
      { key = "?", mods = "NONE", action = act.CopyMode("JumpReverse") },
      {
        key = "N",
        mods = "NONE",
        action = act.CopyMode({ JumpBackward = { prev_char = false } }),
      },
      {
        key = "N",
        mods = "SHIFT",
        action = act.CopyMode({ JumpBackward = { prev_char = false } }),
      },
      {
        key = "G",
        mods = "NONE",
        action = act.CopyMode("MoveToScrollbackBottom"),
      },
      {
        key = "G",
        mods = "SHIFT",
        action = act.CopyMode("MoveToScrollbackBottom"),
      },
      { key = "j", mods = "NONE", action = act.CopyMode("MoveLeft") },
      { key = "k", mods = "NONE", action = act.CopyMode("MoveDown") },
      { key = "l", mods = "NONE", action = act.CopyMode("MoveUp") },
      { key = ";", mods = "NONE", action = act.CopyMode("MoveRight") },
      {
        key = "n",
        mods = "NONE",
        action = act.CopyMode({ JumpForward = { prev_char = true } }),
      },
      {
        key = "y",
        mods = "NONE",
        action = act.Multiple({
          act.CopyTo("ClipboardAndPrimarySelection"),
          act.CopyMode("ClearSelectionMode"),
        }),
      },
      {
        key = "Enter",
        mods = "NONE",
        action = act.CopyMode("MoveToStartOfNextLine"),
      },
      {
        key = "Escape",
        mods = "NONE",
        action = close_copy_mode(),
      },
      {
        key = "Space",
        mods = "NONE",
        action = act.CopyMode({ SetSelectionMode = "Cell" }),
      },
      {
        key = "$",
        mods = "NONE",
        action = act.CopyMode("MoveToEndOfLineContent"),
      },
      {
        key = "$",
        mods = "SHIFT",
        action = act.CopyMode("MoveToEndOfLineContent"),
      },
      {
        key = "0",
        mods = "NONE",
        action = act.CopyMode("MoveToStartOfLine"),
      },
      {
        key = "G",
        mods = "NONE",
        action = act.CopyMode("MoveToScrollbackBottom"),
      },
      {
        key = "G",
        mods = "SHIFT",
        action = act.CopyMode("MoveToScrollbackBottom"),
      },
      {
        key = "H",
        mods = "NONE",
        action = act.CopyMode("MoveToViewportTop"),
      },
      {
        key = "H",
        mods = "SHIFT",
        action = act.CopyMode("MoveToViewportTop"),
      },
      {
        key = "L",
        mods = "NONE",
        action = act.CopyMode("MoveToViewportBottom"),
      },
      {
        key = "L",
        mods = "SHIFT",
        action = act.CopyMode("MoveToViewportBottom"),
      },
      {
        key = "M",
        mods = "NONE",
        action = act.CopyMode("MoveToViewportMiddle"),
      },
      {
        key = "M",
        mods = "SHIFT",
        action = act.CopyMode("MoveToViewportMiddle"),
      },
      {
        key = "O",
        mods = "NONE",
        action = act.CopyMode("MoveToSelectionOtherEndHoriz"),
      },
      {
        key = "O",
        mods = "SHIFT",
        action = act.CopyMode("MoveToSelectionOtherEndHoriz"),
      },
      {
        key = "V",
        mods = "NONE",
        action = act.CopyMode({ SetSelectionMode = "Line" }),
      },
      {
        key = "V",
        mods = "SHIFT",
        action = act.CopyMode({ SetSelectionMode = "Line" }),
      },
      {
        key = "^",
        mods = "NONE",
        action = act.CopyMode("MoveToStartOfLineContent"),
      },
      {
        key = "^",
        mods = "SHIFT",
        action = act.CopyMode("MoveToStartOfLineContent"),
      },
      {
        key = "b",
        mods = "NONE",
        action = act.CopyMode("MoveBackwardWord"),
      },
      {
        key = "b",
        mods = "ALT",
        action = act.CopyMode("MoveBackwardWord"),
      },
      { key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
      {
        key = "c",
        mods = "CTRL",
        action = act.Multiple({
          { CopyMode = "MoveToScrollbackBottom" },
          { CopyMode = "Close" },
        }),
      },
      {
        key = "d",
        mods = "CTRL",
        action = act.CopyMode({ MoveByPage = 0.5 }),
      },
      {
        key = "e",
        mods = "NONE",
        action = act.CopyMode("MoveForwardWordEnd"),
      },
      { key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
      {
        key = "g",
        mods = "NONE",
        action = act.CopyMode("MoveToScrollbackTop"),
      },
      {
        key = "m",
        mods = "ALT",
        action = act.CopyMode("MoveToStartOfLineContent"),
      },
      {
        key = "o",
        mods = "NONE",
        action = act.CopyMode("MoveToSelectionOtherEnd"),
      },
      {
        key = "q",
        mods = "NONE",
        action = act.Multiple({
          { CopyMode = "MoveToScrollbackBottom" },
          { CopyMode = "Close" },
        }),
      },
      {
        key = "u",
        mods = "CTRL",
        action = act.CopyMode({ MoveByPage = -0.5 }),
      },
      {
        key = "v",
        mods = "NONE",
        action = act.CopyMode({ SetSelectionMode = "Cell" }),
      },
      {
        key = "v",
        mods = "CTRL",
        action = act.CopyMode({ SetSelectionMode = "Block" }),
      },
      {
        key = "w",
        mods = "NONE",
        action = act.CopyMode("MoveForwardWord"),
      },
      {
        key = "y",
        mods = "NONE",
        action = act.CopyTo("ClipboardAndPrimarySelection"),
      },
      { key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
      {
        key = "PageDown",
        mods = "NONE",
        action = act.CopyMode("PageDown"),
      },
      {
        key = "End",
        mods = "NONE",
        action = act.CopyMode("MoveToEndOfLineContent"),
      },
      {
        key = "Home",
        mods = "NONE",
        action = act.CopyMode("MoveToStartOfLine"),
      },
      {
        key = "LeftArrow",
        mods = "NONE",
        action = act.CopyMode("MoveLeft"),
      },
      {
        key = "LeftArrow",
        mods = "ALT",
        action = act.CopyMode("MoveBackwardWord"),
      },
      {
        key = "RightArrow",
        mods = "NONE",
        action = act.CopyMode("MoveRight"),
      },
      {
        key = "RightArrow",
        mods = "ALT",
        action = act.CopyMode("MoveForwardWord"),
      },
      { key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
      {
        key = "DownArrow",
        mods = "NONE",
        action = act.CopyMode("MoveDown"),
      },
    },
  }
end

return M
