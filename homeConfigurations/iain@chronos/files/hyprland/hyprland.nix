{
  # Applications
  "$configs" = "~/.config";
  "$terminal" = "kitty";
  "$fileManager" = "thunar";

  bind = [
    "$mainMod, Q, exec, $terminal"
    "$mainMod, E, exec, $fileManager"
    "$mainMod, space, exec, $configs/wofi/launch.sh"
    "$mainMod, x, exec, $configs/wofi/powermenu.sh"
    "$mainMod, b, exec, $configs/wofi/bluetooth.sh"
    "$mainMod, l, exec, sleep 1 && hyprctl -i 0 dispatch dpms standby"
    ", Print, exec, /home/iain/.config/swappy/screenshot.sh"
    "SHIFT, Print, exec, $configs/swappy/edit-clipboard.sh"
  ];

  monitor = [
    "desc:GIGA-BYTE TECHNOLOGY CO. LTD. G34WQC A 21442B000619,3440x1440@144,0x0,1"
    "desc:LG Electronics 23MP65,1920x1080@60,3440x0,1"
  ];

  workspace = [
    "1, monitor:desc:GIGA-BYTE TECHNOLOGY CO. LTD. G34WQC A 21442B000619, default:true"
    "2, monitor:desc:LG Electronics 23MP65, default:true"
  ];

  windowrule = [
    "workspace 2, match:class discord"
  ];
}
