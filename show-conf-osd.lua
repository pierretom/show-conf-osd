-- Global variables

-- Number of lines to display at once
local display_lines = 32

-- Flag to indicate if the OSD should be displayed
local osd_visible = false

-- Table to hold the lines of the OSD
local osd_lines = {}

-- Variable to keep track of the current position in the OSD
local current_line = 1

--

local function truncate_line(str)
    local max_length = 100
    local current_length = 0
    local bytes = {string.byte(str, 1, -1)}

    for i, b in ipairs(bytes) do
        if b < 128 or b > 191 then
            current_length = current_length + 1
        end
        if current_length > max_length then
            return string.sub(str, 1, i - 1) .. '...'
        end
    end

    return str
end

local function read_conf(config_file)
    -- Path of the configuration file
    local config_path

    -- Reset the lines of the OSD
    osd_lines = {}

    -- Reset the current position in the OSD
    current_line = 1

    if package.config:sub(1,1) == '\\' or os.getenv('WINDIR') then
        config_path = os.getenv('APPDATA') .. '/mpv/' .. config_file
    else
        config_path = os.getenv('HOME') .. '/.config/mpv/' .. config_file
    end

    -- Try to open the file
    local file = io.open(config_path, "r")
    if not file then
        if not config_path then
            mp.osd_message("Cannot open " .. config_file, 5)
        else
            mp.osd_message("Cannot open " .. config_path, 5)
        end

        return
    end

    -- Read the file line by line and store in the table
    for line in file:lines() do
        line = truncate_line(line)
        table.insert(osd_lines, line)
    end

    file:close()
end

-- Function to display the config file on the OSD
local function show_config_osd()
    if #osd_lines == 0 then return end -- Nothing to display

    local osd_text = ""
    for i = 0, display_lines - 1 do
        local line_index = current_line + i
        if line_index <= #osd_lines then
            osd_text = osd_text .. osd_lines[line_index] .. "\n"
        end
    end

    if osd_visible then
        -- Use a very long duration to keep the OSD visible (24h)
        mp.osd_message(osd_text, 86400)
    else
        -- Hide the OSD
        mp.osd_message("")
        mp.remove_key_binding("scroll_up")
        mp.remove_key_binding("scroll_down")
    end
end

-- Function to scroll up
local function scroll_up()
    if current_line > 1 then
        current_line = current_line - 1
        show_config_osd()
    end
end

-- Function to scroll down
local function scroll_down()
    if current_line + display_lines <= #osd_lines then
        current_line = current_line + 1
        show_config_osd()
    end
end

-- Function to toggle OSD visibility
local function toggle_config_osd(config_file)
    osd_visible = not osd_visible

    -- Forced keybindings to scroll
    mp.add_forced_key_binding("UP", "scroll_up", scroll_up, {repeatable=true})
    mp.add_forced_key_binding("DOWN", "scroll_down", scroll_down, {repeatable=true})

    read_conf(config_file)
    show_config_osd()
end

-- Keybinds
mp.add_key_binding("a", "show-mpv-conf", function()
    toggle_config_osd("mpv.conf")
end)

mp.add_key_binding("c", "show-input-conf", function()
    toggle_config_osd("input.conf")
end)

mp.add_key_binding("h", "show-fonts-conf", function()
    toggle_config_osd("fonts.conf")
end)

mp.add_key_binding("y", "show-channels-conf", function()
    toggle_config_osd("channels.conf")
end)

mp.add_key_binding(nil, "show-video-avi-conf", function()
    toggle_config_osd("video.avi.conf")
end)

mp.add_key_binding("k", "show-osc-conf", function()
    toggle_config_osd("script-opts/osc.conf")
end)

mp.add_key_binding("n", "show-console-conf", function()
    toggle_config_osd("script-opts/console.conf")
end)

mp.add_key_binding(nil, "show-stats-conf", function()
    toggle_config_osd("script-opts/stats.conf")
end)

mp.add_key_binding(nil, "show-commands-conf", function()
    toggle_config_osd("script-opts/commands.conf")
end)

mp.add_key_binding(nil, "show-select-conf", function()
    toggle_config_osd("script-opts/select.conf")
end)

mp.add_key_binding(nil, "show-positioning-conf", function()
    toggle_config_osd("script-opts/positioning.conf")
end)

mp.add_key_binding(nil, "show-identifier-conf", function()
    toggle_config_osd("script-opts/identifier.conf")
end)
