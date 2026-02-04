let
  keyboard = "gb";

  active_colour = "rgba(4CAF50F2) rgba(00FF99EE) 45deg";
  inactive_colour = "rgba(595959aa)";
in {
  "$mainMod" = "SUPER";

  ecosystem = {
    no_update_news = true;
    no_donation_nag = true;
  };

  input = {
    # Keyboard
    kb_layout = keyboard;

    # Mouse
    sensitivity = 0;
    follow_mouse = 2; # Cursor can hover and scroll, but won't move keyboard (main) focus, clicking moves focus
    float_switch_override_focus = 0;
  };

  general = {
    # Border
    border_size = 2;
    "col.active_border" = active_colour;
    "col.inactive_border" = inactive_colour;

    # Gaps
    gaps_in = 5;
    gaps_out = 10;

    # Layout
    layout = "dwindle";
  };

  decoration = {
    rounding = 10;

    blur = {
      enabled = true;
    };

    shadow = {
      enabled = true;
    };
  };

  animations = {
    enabled = true;

    bezier = [
      "overShoot, 0.05, 0.9, 0.1, 1.05"
    ];

    animation = [
      "windows, 1, 7, overShoot"
      "windowsOut, 1, 7, default, popin 80%"
      "border, 1, 10, default"
      "borderangle, 1, 8, default"
      "fade, 1, 7, default"
      "workspaces, 1, 6, default"
    ];
  };

  dwindle = {
    pseudotile = "yes";
    preserve_split = "yes";
  };

  misc = {
    # Wallpaper
    force_default_wallpaper = -1;
    disable_splash_rendering = true;

    # Ensure we can wakeup
    mouse_move_enables_dpms = true;
    key_press_enables_dpms = true;

    # Stop applications showing "Not Responding" dialogue
    enable_anr_dialog = false;

    # Disable middle click paste
    middle_click_paste = false;
  };

  bindm = [
    # Move and resize with mouse
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
  ];

  bind = [
    # Main keybinds
    "$mainMod, M, exit" # Kill entire hyprland session
    "$mainMod, C, killactive"
    "$mainMod, V, togglefloating"
    "$mainMod, J, togglesplit"
    "$mainMod, F, fullscreen"

    # Move focus
    "$mainMod, left, movefocus, l"
    "$mainMod, right, movefocus, r"
    "$mainMod, up, movefocus, u"
    "$mainMod, down, movefocus, d"

    # Resize windows
    "$mainMod SHIFT, left, resizeactive, -20 0"
    "$mainMod SHIFT, right, resizeactive, 20 0"
    "$mainMod SHIFT, up, resizeactive, 0 -20"
    "$mainMod SHIFT, down, resizeactive, 0 20"

    # Workspaces
    "$mainMod, 1, workspace, 1"
    "$mainMod, 2, workspace, 2"
    "$mainMod, 3, workspace, 3"
    "$mainMod, 4, workspace, 4"
    "$mainMod, 5, workspace, 5"
    "$mainMod, 6, workspace, 6"
    "$mainMod, 7, workspace, 7"
    "$mainMod, 8, workspace, 8"
    "$mainMod, 9, workspace, 9"
    "$mainMod, 0, workspace, 10"
    "$mainMod, S, togglespecialworkspace, magic"
    # Scroll Workspaces
    "$mainMod, mouse_down, workspace, e+1"
    "$mainMod, mouse_up, workspace, e-1"

    # Move window to workspace
    "$mainMod SHIFT, 1, movetoworkspace, 1"
    "$mainMod SHIFT, 2, movetoworkspace, 2"
    "$mainMod SHIFT, 3, movetoworkspace, 3"
    "$mainMod SHIFT, 4, movetoworkspace, 4"
    "$mainMod SHIFT, 5, movetoworkspace, 5"
    "$mainMod SHIFT, 6, movetoworkspace, 6"
    "$mainMod SHIFT, 7, movetoworkspace, 7"
    "$mainMod SHIFT, 8, movetoworkspace, 8"
    "$mainMod SHIFT, 9, movetoworkspace, 9"
    "$mainMod SHIFT, 0, movetoworkspace, 10"
    "$mainMod SHIFT, S, movetoworkspace, special:magic"

    # Media keys
    ",XF86AudioPlay,exec,playerctl play-pause"
    # Output audio
    ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
    ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ",XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    # Input audio
    "ALT,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+"
    "ALT,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-"
    "ALT,XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
  ];
}
