local mod = "SUPER"

function keys(...)
    return table.concat({ ... }, " + ")
end

hl.bind(
    keys(mod, "SPACE"),
    hl.dsp.global("quickshell:openApplicationLauncher"),
    { description = "Open the Application Launcher" }
)
hl.bind(
    keys(mod, "V"),
    hl.dsp.global("quickshell:openClipboardHistory"),
    { description = "Open the Clipboard History" }
)
hl.bind(
    keys(mod, "B"),
    hl.dsp.global("quickshell:openBluetoothSettings"),
    { description = "Open the Bluetooth setting" }
)
hl.bind(
    keys(mod, "X"),
    hl.dsp.global("quickshell:openSystemMenu"),
    { description = "Launch the     System Menu" }
)
