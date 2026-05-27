-- Mouse Bindings
local mod = "SUPER"
local terminal = "kitty"
local fileManager = "thunar"
local LMB = "mouse:272"
local RMB = "mouse:273"
local MMB = "mouse:274"

function keys(...)
    return table.concat({ ... }, " + ")
end

hl.bind(
    keys(mod, LMB),
    hl.dsp.window.drag(),
    {
        mouse = true,
        description = "Move Windows",
    }
)

hl.bind(
    keys(mod, RMB),
    hl.dsp.window.resize(),
    {
        mouse = true,
        description = "Resize Windows",
    }
)

-- Keyboard Bindings
hl.bind(
    keys("CTRL", "ALT", "DELETE"),
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"),
    { description = "Kill Hyprland" }
)
hl.bind(
    keys(mod, "C"),
    hl.dsp.window.close(),
    { description = "Close Window" }
)
hl.bind(
    keys(mod, "Q"),
    hl.dsp.exec_cmd(terminal),
    { description = "Open Terminal" }
)
hl.bind(
    keys(mod, "E"),
    hl.dsp.exec_cmd(fileManager),
    { description = "Open File Manager" }
)
hl.bind(
    keys(mod, "F"),
    hl.dsp.window.fullscreen({ action = "toggle" }),
    { description = "Toggle Fullscreen" }
)
hl.bind(
    keys(mod, "V"),
    hl.dsp.window.float({ action = "toggle" }),
    { description = "Toggle Float" }
)
hl.bind(
    keys(mod, "J"),
    hl.dsp.layout("togglesplit"),
    { description = "Toggle Split Layout" }
)
hl.bind(
    keys(mod, "L"),
    hl.dsp.exec_cmd("sleep 1 && hyprctl -i 0 dispatch dpms standby"),
    { description = "Sleep Monitors" }
)

-- Move Window Focus
hl.bind(
    keys(mod, "left"),
    hl.dsp.focus({ direction = "left" })
)
hl.bind(
    keys(mod, "right"),
    hl.dsp.focus({ direction = "right" })
)
hl.bind(
    keys(mod, "up"),
    hl.dsp.focus({ direction = "up" })
)
hl.bind(
    keys(mod, "down"),
    hl.dsp.focus({ direction = "down" })
)

-- Workspace Focus
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(
        keys(mod, key),
        hl.dsp.focus({ workspace = i })
    )
    hl.bind(
        keys(mod, "SHIFT", key),
        hl.dsp.window.move({ workspace = i })
    )
end

-- Special Workspace
hl.bind(
    keys(mod, "S"),
    hl.dsp.workspace.toggle_special("magic")
)
hl.bind(
    keys(mod, "SHIFT", "S"),
    hl.dsp.window.move({ workspace = "special:magic" })
)

-- Volume Keys
local volume_delta = 5
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ " .. volume_delta .. "%+"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. volume_delta .. "%-"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true }
)

-- Media Controls
hl.bind(
    "XF86AudioPlay",
    hl.dsp.exec_cmd("playerctl play-pause"), { locked = true }
)
hl.bind(
    "XF86AudioPause",
    hl.dsp.exec_cmd("playerctl play-pause"), { locked = true }
)
hl.bind(
    "XF86AudioNext",
    hl.dsp.exec_cmd("playerctl next"), { locked = true }
)
hl.bind(
    "XF86AudioPrev",
    hl.dsp.exec_cmd("playerctl previous"), { locked = true }
)

-- Monitor Brightness
hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true }
)
hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true }
)
