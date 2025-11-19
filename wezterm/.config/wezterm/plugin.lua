local M = {}

function M.setup(wezterm, config)
  local dir = "/home/dlroweht/.config/wezterm/plugins"
  for _, v in ipairs(wezterm.read_dir(dir)) do
    if string.match(v, "%.lua$") then
      loadfile(v)().setup(wezterm, config)
    end
  end
end

return M
