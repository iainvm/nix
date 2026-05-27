local mod = "SUPER"
local config = "~/.config/"

local main_monitor = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. G34WQC A 21442B000619"
local side_monitor = "desc:LG Electronics 23MP65 0x0006E8B5"

hl.monitor({
    output = main_monitor,
    mode = "3440x1440@144",
    position = "0x0",
    scale = 1,
})
hl.monitor({
    output = side_monitor,
    mode = "1920x1080@60",
    position = "3440x0",
    scale = 1,
})

hl.workspace_rule({
    workspace = "1",
    monitor = main_monitor,
    default = true,
})
hl.workspace_rule({
    workspace = "2",
    monitor = side_monitor,
    default = true,
})

function keys(...)
    return table.concat({ ... }, " + ")
end

hl.bind(
    keys(mod, "SPACE"),
    hl.dsp.exec_cmd(config .. "wofi/launch.sh"),
    { description = "Launch Wofi" }
)
hl.bind(
    keys(mod, "X"),
    hl.dsp.exec_cmd(config .. "wofi/powermenu.sh"),
    { description = "Launch Power Menu" }
)
hl.bind(
    keys(mod, "B"),
    hl.dsp.exec_cmd(config .. "wofi/bluetooth.sh"),
    { description = "Launch Bluetooth Menu" }
)
hl.bind(
    keys("Print"),
    hl.dsp.exec_cmd(config .. "swappy/screenshot.sh"),
    { description = "Print Screen" }
)
hl.bind(
    keys("SHIFT", "Print"),
    hl.dsp.exec_cmd(config .. "swappy/edit-clipboard.sh"),
    { description = "Edit Clipboard Image" }
)

hl.window_rule({
    match = {
        class = "discord",
    },
    workspace = "2",
})
