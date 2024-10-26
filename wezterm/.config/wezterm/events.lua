local M = {}

local function clean_process_name(proc)
    local a = string.gsub(proc, "(.*[/\\])(.*)", "%2")
    return a:gsub("%.exe$", "")
end

local function make_tab_title(pane, tab_index, base_title, max_width)
    local title = ""
    local proc_name = clean_process_name(pane.foreground_process_name)
    title = " " .. tostring(tab_index) .. ": "
    if proc_name:len() > 0 then
        title = title .. proc_name .. " "
    else
        title = title .. base_title .. " "
    end
    if title:len() > max_width then
        local diff = title:len() - max_width
        title = title:sub(1, title:len() - diff - 1)
        title = title .. " "
    else
        local padding = max_width - title:len()
        title = title .. string.rep(" ", padding)
    end
    return title
end

function M.setup(wezterm)
    wezterm.on("format-tab-title", function(tab, _, _, _, _, max_width)
        local pane = tab.active_pane
        local title = make_tab_title(pane, tab.tab_index, pane.title, max_width)
        return wezterm.format({ { Text = title } })
    end)

    wezterm.on("update-right-status", function(window, _)
        local prefix = ""
        if window:leader_is_active() then
            prefix = " " .. utf8.char(0xf0627) .. " "
        end
        window:set_left_status(wezterm.format({
            { Background = { Color = "#fb4934" } },
            { Foreground = { Color = "#1d2021" } },
            { Text = prefix },
        }))
    end)
end

return M
