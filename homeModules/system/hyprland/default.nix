{
  lib,
  config,
  ...
}: {
  options.system.hyprland = {
    enable = lib.mkEnableOption "enable hyprland";
  };

  config = lib.mkIf config.system.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
    };
  };
}
