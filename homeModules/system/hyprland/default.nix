{
  lib,
  pkgs,
  config,
  ...
}: let
  default-settings = import ./files/default-settings.nix;
in {
  options.system.hyprland = {
    enable = lib.mkEnableOption "enable hyprland";
    settings = lib.mkOption {
      type = lib.types.path;
      default = "";
      description = "System specific hyprland config";
    };
  };

  config = lib.mkIf config.system.hyprland.enable {
    home.file = {
      ".config/hypr/main.lua".source = ./files/main.lua;
      ".config/hypr/animations.lua".source = ./files/animations.lua;
      ".config/hypr/binds.lua".source = ./files/binds.lua;
      ".config/hypr/window-rules.lua".source = ./files/window-rules.lua;
      ".config/hypr/user.lua".source = config.system.hyprland.settings;
    };

    home.packages = with pkgs; [
      brightnessctl
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";
      extraConfig = ''
        require("main")
        require("animations")
        require("binds")
        require("window-rules")
        require("user")
      '';
    };
  };
}
