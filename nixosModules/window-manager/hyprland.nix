{
  lib,
  config,
  system,
  nixpkgs,
  ...
}: let
  pkgs = nixpkgs.legacyPackages.${system};
in {
  options.hyprland = {
    enable = lib.mkEnableOption "enable hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    # Desktop Environment
    services.xserver = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      xdg-desktop-portal-hyprland
    ];

    programs.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      xwayland.enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    xdg.portal = {
      enable = true;
      extraPortals = [];
    };

    # Setting to make ultrawide the primary monitor for Xwayland
    # Broken
    # https://github.com/NixOS/nixpkgs/issues/72250
    # https://github.com/NixOS/nixpkgs/issues/30796
    # services.xserver.xrandrHeads = [
    #   {
    #     output = "DP-4";
    #     primary = true;
    #   }
    # ];
  };
}
