#!/bin/sh

connected_icon=✓
battery_icon=🔋
nickname_list="OpenRun Pro 2 by Shokz|OpenRun Pro 2"


# Get list of paired mac addresses
get_paired_devices() {
    bluetoothctl devices Paired | grep "Device" | awk '{print $2}'
}

# Get the name of the device and process any nicknames
device_name() {
    mac="$1"
    name=$(bluetoothctl info "$mac" | awk -F': ' '/Name:/ {print $2}')

    found=""
    while IFS='|' read -r full nickname; do
        if [ "$name" = "$full" ]; then
            found="$nickname"
            break
        fi
    done <<EOF
$nickname_list
EOF

    if [ -n "$found" ]; then
        echo "$found"
    else
        echo "$name"
    fi
}

# Check if device is connected
device_connected() {
    mac="$1"
    if bluetoothctl devices Connected | grep -q "$mac"; then
        echo $connected_icon
    fi
}

# Returns the battery percentage of the given device
device_battery() {
    mac="$1"
    percentage=$(bluetoothctl info "$mac" | awk -F '[()]' '/Battery Percentage:/ {print $2}')

    if [ -n "$percentage" ]; then
        echo "$battery_icon$percentage"
    else
        echo ""
    fi
}

create_list() {
    device_list=""

    while read -r device; do
        # entry="[$device] $(device_name "$device") $(device_connected "$device") $(device_battery "$device")"
        entry="[$device] $(device_name "$device") $(device_battery "$device")"

        if [ -z "$device_list" ]; then
            device_list="$entry"
        else
            device_list="$(printf '%s\n%s' "$device_list" "$entry")"
        fi
    done <<EOF
$(get_paired_devices)
EOF

    echo "$device_list"
}

# Show in Wofi
selection=$(printf '%s' "$(create_list)" | sort | wofi -i --dmenu -p "Bluetooth Devices")

# Extract MAC address from selection
mac=$(echo "$selection" | grep -oE '([A-F0-9]{2}:){5}[A-F0-9]{2}')

# Make sure we have a selection to action
if [ -n "$selection" ]; then
    # Toggle connect/disconnect the device
    if bluetoothctl devices Connected | grep -q "$mac"; then
        bluetoothctl disconnect "$mac"
    else
        i=1
        while [ "${i}" -le 5 ]; do
            if bluetoothctl connect "$mac"; then
                echo "Connected on attempt $i"
                break
            else
                echo "Attempt $i failed"
                sleep 2
            fi
            i=$((i + 1))
        done
    fi
fi
