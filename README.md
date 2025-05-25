# show-conf-osd

A Lua script for [mpv](https://mpv.io) to display configuration files on the OSD.

## Installation

Place `show-conf-osd.lua` it in the corresponding mpv `scripts` folder of your operating system:

* Linux & BSD:
  - `$XDG_CONFIG_HOME/mpv/scripts` or
  - `~/.config/mpv/scripts` or
  - `/home/<username>/.config/mpv/scripts`
* macOS:
  - `$HOME/.config/mpv/scripts` or
  - `~/.config/mpv/scripts` or
  - `/Users/<username>/.config/mpv/scripts`
* Windows:
  - `%APPDATA%\mpv\scripts` or
  - `c:\users\<username>\AppData\Roaming\mpv\scripts`

## Usage

Configuration files are searched in the user mpv directory:
* Unix like:
  - $HOME/.config/mpv
* Windows:
  -  c:\users\<username>\AppData\Roaming\mpv

Press a key to switch to the display of a configuration file, press again to hide.

#### Default key bindings

| Key           | Action |
| ---           | --- |
| a             | Display mpv.conf |
| c             | Display input.conf |
| h             | Display fonts.conf |
| y             | Display channels.conf |
| Unassigned    | Display video.avi.conf |
| k             | Display script-opts/osc.conf |
| n             | Display script-opts/console.conf |
| Unassigned    | Display script-opts/stats.conf |
| Unassigned    | Display script-opts/commands.conf |
| Unassigned    | Display script-opts/select.conf |
| Unassigned    | Display script-opts/positioning.conf |
| Unassigned    | Display script-opts/identifier.conf |
| UP            | Scroll up |
| DOWN          | Scroll down |

You can assign or reassign it in the script or in the `input.conf` file:

```
yourkey     script-binding show-mpv-conf
yourkey     script-binding show-input-conf
yourkey     script-binding show-fonts-conf
yourkey     script-binding show-channels-conf
yourkey     script-binding show-video-avi-conf
yourkey     script-binding show-osc-conf
yourkey     script-binding show-console-conf
yourkey     script-binding show-stats-conf
yourkey     script-binding show-commands-conf
yourkey     script-binding show-select-conf
yourkey     script-binding show-positioning-conf
yourkey     script-binding show-identifier-conf
```

## Notes

1. The script has not been tested on macOS and Windows, please report if you have issues.

2. It is recommended to use a fixed-width font for the OSD with this script, to keep text formating from configuration files.

Examples:

- DejaVu Sans Mono
- Liberation Mono
- Menlo
- Monaco
- Consolas
- Courier New

3. If you cannot see some lines on the OSD, you can ajust the number of lines to display at once in the script, e.g.:

```
local display_lines = 28
```
