---------------------
---- KEYBINDINGS ----
---------------------


-- Set programs that you use
local terminal    = "kitty"
local fileManager = "thunar"
local ipc         = "qs -c noctalia-shell ipc call "


local mainMod = "SUPER"

-- Window management
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"), { description = "Quit active window and all open instances" })

hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + R", hl.dsp.layout("togglesplit"))

-- Focus Movement
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left"}))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right"}))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up"}))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down"}))

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "l" }), { description = "Swap tiled window left" })
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "r" }), { description = "Swap tiled window right" })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "u" }), { description = "Swap tiled window up" })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "d" }), { description = "Swap tiled window down" })

-- Fullscreen
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle"}),          { description = "Toggle Maximize Window" })
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle"}), { description = "Toggle Maximize Window" })

-- Groups
-- hl.bind(mainMod .. " + G", hl.dsp.group.toggle(), { description = "Toggle window group" })

-- Noctalia shell
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd([[pgrep -x qs >/dev/null && pkill qs || qs -c noctalia-shell]]))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(ipc .. "launcher toggle"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(ipc .. "controlCenter toggle"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(ipc .. "lockScreen lock"))

-- Hyprpicker
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprpicker -a"))

-- Screenshots
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd([[grim ~/Pictures/Screenshots/screenshot_$(date +%s).png]]))
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd([[grim -g "$(slurp)" ~/Pictures/Screenshots/screenshot_$(date +%s).png]]))
hl.bind(mainMod .. " + CTRL + Print", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy]]))


-- Workspaces
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Scratchpad
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true }, { description = "Increase window width with keyboard" })
hl.bind(mainMod .. " + left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true }, { description = "Reduce window width with keyboard" })
hl.bind(mainMod .. " + down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true }, { description = "Increase window height with keyboard" })
hl.bind(mainMod .. " + up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true }, { description = "Reduce window height with keyboard" })


-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl s 5%+"),                            { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl s 5%-"),                            { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
