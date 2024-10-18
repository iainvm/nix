{
  lib,
  config,
  ...
}: {
  options.hyprland = {
    enable = lib.mkEnableOption "enable hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
    };
  };
}
