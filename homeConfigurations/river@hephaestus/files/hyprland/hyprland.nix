{
  # Applications
  "$configs" = "~/.config";
  "$terminal" = "kitty";
  "$fileManager" = "thunar";

  env = [
    "AQ_NO_MODIFIERS,1"
  ];

  bind = [
    "$mainMod, Q, exec, $terminal"
    "$mainMod, E, exec, $fileManager"
    "$mainMod, space, exec, $configs/wofi/launch.sh"
    "$mainMod, x, exec, $configs/wofi/powermenu.sh"
    "$mainMod, b, exec, $configs/wofi/bluetooth.sh"
    "$mainMod, l, exec, sleep 1 && hyprctl -i 0 dispatch dpms standby"
    ", Print, exec, $configs/swappy/screenshot.sh"
    "SHIFT, Print, exec, $configs/swappy/edit-clipboard.sh"
    ",XF86MonBrightnessUp,exec,brightnessctl set 10%+"
    ",XF86MonBrightnessDown,exec,brightnessctl set 10%-"
  ];

  monitor = [
    "desc:LG Electronics 23MP65 0x0006E8D2,1920x1080@60,0x0,1"
    "desc:GIGA-BYTE TECHNOLOGY CO. LTD. G34WQC A 21512B002947,3440x1440@100,1920x0,1"
    "desc:BOE NE135A1M-NY1,2880x1920@120,5360x0,1"
  ];

  workspace = [
    "1, monitor:desc:LG Electronics 23MP65 0x0006E8D2, default:true"
    "2, monitor:desc:GIGA-BYTE TECHNOLOGY CO. LTD. G34WQC A 21512B002947, default:true"
    "3, monitor:desc:BOE NE135A1M-NY1, default:true"
  ];

  windowrule = [
    "workspace 3, match:class teams-for-linux"
    "workspace 3, match:class discord"
  ];
}
