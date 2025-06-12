#!/bin/sh

# Get list of all paired devices
# Format "$mac $name"
# paired="$(printf '%s\n%s' "AA:AA:AA:AA:AA:AA test-device" "AC:80:0A:29:DA:D3 WF-1000XM5")"
paired=$(bluetoothctl devices Paired | awk '{print $2, $3}')

# Get list connected devices
# Format "$mac"
# connected="$(printf '%s\n%s' "AA:AA:AA:AA:AA:AA" "AC:80:0A:29:DA:D3")"
connected=$(bluetoothctl info | grep "^Device" | awk '{print $2}')

# Build list of devices for selection
# For each paired device
while read -r device; do
    # Separate out the device info
    mac=$(echo "$device" | awk '{print $1}')
    name=$(echo "$device" | awk '{print $2}')

    # Add an icon if an entry is connected
    if echo "$connected" | grep -q "$mac"; then
        entry="$name [$mac] ✓"
    else
        entry="$name [$mac]"
    fi

    # Add the entry to the device list
    # Only append if it's not the first value
    if [ -z "${device_list+x}" ]; then
        device_list="$entry"
    else
        device_list="$(printf '%s\n%s' "$device_list" "$entry")"
    fi
done << EOF
$paired
EOF

# Show in Wofi
selection=$(printf '%s' "$device_list" | sort | wofi -i --dmenu -p "Bluetooth Devices")

# Extract MAC address from selection
mac=$(echo "$selection" | grep -oE '([A-F0-9]{2}:){5}[A-F0-9]{2}')

# Determine if device is currently connected
is_connected=$(bluetoothctl info "$mac" | grep -q "Connected: yes" && echo "yes")

# Toggle connection
if [ -n "$mac" ]; then
    if [ "$is_connected" = "yes" ]; then
        # echo "disconnect: $mac"
        bluetoothctl disconnect "$mac"
    else
        # echo "connect $mac"
        bluetoothctl connect "$mac"
    fi
fi
