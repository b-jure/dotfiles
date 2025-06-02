local M = {}

function M.setup(wezterm, config)
  -- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
  local function is_vim(pane)
    -- this is set by the plugin, and unset on ExitPre in Neovim
    return pane:get_user_vars().IS_NVIM == "true"
  end

  local direction_keys = {
    j = "Left",
    k = "Down",
    l = "Up",
    [";"] = "Right",
  }

  local function split_nav(_, key)
    return {
      key = key,
      mods = "CTRL",
      action = wezterm.action_callback(function(win, pane)
        if is_vim(pane) then
          -- pass the keys through to vim/nvim
          win:perform_action({
            SendKey = { key = key, mods = "CTRL" },
          }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end),
    }
  end

  do -- set keys
    local t = {
      -- move between split panes
      split_nav("move", "j"),
      split_nav("move", "k"),
      split_nav("move", "l"),
      split_nav("move", ";"),
    }
    for _, v in ipairs(t) do
      config.keys[#config.keys + 1] = v
    end
  end
end

return M
