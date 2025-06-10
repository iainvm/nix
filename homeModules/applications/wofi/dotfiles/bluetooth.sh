#!/bin/sh

# Get list of all paired devices
paired=$(bluetoothctl devices Paired)

# Get list of currently connected devices
connected=$(bluetoothctl info | grep "Device" | awk '{print $2}')

# Build device list with [MAC] and connected status
device_list=""
while read -r line; do
    mac=$(echo "$line" | awk '{print $2}')
    name=$(echo "$line" | cut -d ' ' -f 3-)

    if echo "$connected" | grep -q "$mac"; then
        entry="$name [$mac] ✓"
    else
        entry="$name [$mac]"
    fi

    device_list="${device_list}${entry}"
done << EOF
$paired
EOF

# Show in Wofi (trim trailing newline to prevent blank option)
selection=$(printf '%s' "$device_list" | sed '/^\s*$/d' | sort | wofi -i --dmenu -p "Bluetooth Devices")


# Extract MAC address from selection
mac=$(echo "$selection" | grep -oE '([A-F0-9]{2}:){5}[A-F0-9]{2}')

# Determine if device is currently connected
is_connected=$(bluetoothctl info "$mac" | grep -q "Connected: yes" && echo "yes")

# Toggle connection
if [ -n "$mac" ]; then
    if [ "$is_connected" = "yes" ]; then
        bluetoothctl disconnect "$mac"
    else
        bluetoothctl connect "$mac"
    fi
fi
