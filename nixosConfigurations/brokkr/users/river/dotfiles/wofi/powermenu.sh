#!/usr/bin/env bash

options='  Poweroff
  Reboot'
# Not implemented yet
#   Logout
#   Lock
#   Suspend

# Take the 2nd column of selected option
option=$(echo -e "$options" | wofi -i --dmenu | awk '{print tolower($2)}')

case $option in 
    poweroff)
        systemctl poweroff
        ;;
    reboot)
        systemctl reboot
        ;;
    suspend)
        systemctl suspend
        ;;
    lock)
        echo "Lock"
        ;;
    logout)
        echo "Logout"
        ;;
esac