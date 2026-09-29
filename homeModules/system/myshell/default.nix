{
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.myshell.homeManagerModules.default
  ];

  options.system.myshell = {
    enable = lib.mkEnableOption "myshell";
  };

  config = lib.mkIf config.system.myshell.enable {
    myshell.enable = true;

    wayland.windowManager.hyprland.extraConfig = lib.mkIf config.system.hyprland.enable (lib.mkAfter (builtins.readFile ./files/hyprland-binds.lua));
  };
}
