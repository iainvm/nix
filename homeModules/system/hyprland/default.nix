{
  lib,
  config,
  ...
}: {
  options.system.hyprland = {
    enable = lib.mkEnableOption "enable hyprland";
    settings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Default Hyprland configuration";
    };
  };

  config = lib.mkIf config.system.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      # settings = import ./default-settings.nix;
    };
  };
}
