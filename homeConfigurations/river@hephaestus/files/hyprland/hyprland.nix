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
  ];

  monitorv2 = [
    {
      output = "desc:LG Electronics 23MP65 0x0006E8D2";
      mode = "1920x1080@60";
      position = "0x0";
      scale = "1";
    }
    {
      output = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. G34WQC A 21512B002947";
      mode = "3440x1440@100";
      position = "1920x0";
      scale = "1";
    }
    {
      output = "desc:BOE NE135A1M-NY1";
      mode = "2880x1920@120";
      position = "5360x0";
      scale = "1.5";
    }
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
